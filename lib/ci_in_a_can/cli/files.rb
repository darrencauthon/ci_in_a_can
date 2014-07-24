module CiInACan

  module Cli

    class Files

      params_constructor

      attr_accessor :id, :root

      def self.for id, root
        new(id: id, root: root)
      end

      def rake_file
<<EOF
#!/usr/bin/env rake

desc "Start #{@id}"
task :start do
  location = File.expand_path(File.dirname(__FILE__))
  #system "ruby service/service.rb start"
  system "god -c web/web.god"
end

desc "Stop #{@id}"
task :stop do
  location = File.expand_path(File.dirname(__FILE__))
  #system "ruby service/service.rb stop"
  system "god stop #{@id}_ci_web"
end
EOF
      end

      def god_file
        <<EOF
this_directory = File.expand_path(File.dirname(__FILE__))
God.watch do |w|
  w.name = '#{@id}_ci_web'
  w.start = "rackup -p 80"
  w.dir = "\#{this_directory}"
  w.keepalive
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

eval("CiInACan::Web.jobs_location = '\#{this_directory}' + '/jobs'")
eval("CiInACan.results_location = '\#{this_directory}' + '/results'")

use CiInACan::Sinatra
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
