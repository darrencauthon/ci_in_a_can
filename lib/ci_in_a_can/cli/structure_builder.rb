module CiInACan

  module Cli

    class StructureBuilder

      def initialize root, id
        @root = root
        @id   = id
      end

      def create
        directories_to_create = [@root, "#{@root}/jobs", "#{@root}/repos", "#{@root}/web", "#{@root}/service", "#{@root}/results"]

        directories_to_create.each { |d| Dir.mkdir(d) unless File.exists?(d) }

        File.open("#{@root}/Rakefile", 'w')           { |f| f.write rake_file    }
        File.open("#{@root}/service/service.rb", 'w') { |f| f.write service_file }
        File.open("#{@root}/web/stay_alive.rb", 'w')  { |f| f.write web_daemon   }
        File.open("#{@root}/web/config.ru", 'w')      { |f| f.write web_file     }
      end

      def rake_file
<<EOF
#!/usr/bin/env rake

desc "Start #{@id}"
task :start do
  location = File.expand_path(File.dirname(__FILE__))
  system "ruby service/service.rb start"
  system "ruby web/stay_alive.rb start"
end

desc "Stop #{@id}"
task :stop do
  location = File.expand_path(File.dirname(__FILE__))
  system "ruby service/service.rb stop"
end
EOF
      end

      def web_daemon
<<EOF
require 'daemons'

this_directory = File.expand_path(File.dirname(__FILE__))

::Daemons.run_proc('#{@id}_ci_web') do
  loop do
    exec "cd \#{this_directory};rackup -p 80"
  end
end
EOF
      end

      def web_file
  <<EOF
require 'ci_in_a_can'

this_directory = File.expand_path(File.dirname(__FILE__) + '/../')

eval("CiInACan::App.jobs_location = '\#{this_directory}' + '/jobs'")
eval("CiInACan.results_location = '\#{this_directory}' + '/results'")

use CiInACan::App
run Sinatra::Application
EOF
      end

      def service_file
  <<EOF
require 'ci_in_a_can'
require 'daemons'

this_directory = File.expand_path(File.dirname(__FILE__) + '/../')

eval("CiInACan.results_location = '\#{this_directory}' + '/results'")

::Daemons.run_proc('#{@id}_ci_server') do
  loop do
    options = {
                access_token:      ENV['GITHUB_AUTH_TOKEN'],
                working_location:  this_directory + "/repos",
                watching_location: this_directory + "/jobs",
                site_url:          ENV['SITE_URL']
              }
    CiInACan::Daemon.start options
    sleep
  end
end
EOF
      end

    end
  end
end
