module CiInACan

  module Cli

    class StructureBuilder

      params_constructor

      attr_accessor :root, :id

      def create
        directories_to_create = [@root, "#{@root}/jobs", "#{@root}/repos", "#{@root}/web", "#{@root}/service", "#{@root}/results"]

        directories_to_create.each { |d| Dir.mkdir(d) unless File.exists?(d) }

        files = ::CiInACan::Cli::Files.for @id, @root

        File.open("#{@root}/Rakefile", 'w')           { |f| f.write files.rake_file    }
        File.open("#{@root}/service/service.rb", 'w') { |f| f.write files.service_file }
        File.open("#{@root}/web/stay_alive.rb", 'w')  { |f| f.write files.web_daemon   }
        File.open("#{@root}/web/config.ru", 'w')      { |f| f.write files.web_file     }
      end

    end
  end
end
