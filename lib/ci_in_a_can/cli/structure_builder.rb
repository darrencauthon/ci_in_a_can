module CiInACan

  module Cli

    class StructureBuilder

      params_constructor

      attr_accessor :root, :id

      def create

        create_directories ["#{@root}", "#{@root}/jobs", "#{@root}/repos", "#{@root}/web", "#{@root}/service", "#{@root}/results"]

        files = ::CiInACan::Cli::Files.for @id, @root
        create_file "#{@root}/Rakefile", files.rake_file
        create_file "#{@root}/service/service.rb", files.service_file
        create_file "#{@root}/web/stay_alive.rb", files.web_daemon
        create_file "#{@root}/web/config.ru", files.web_file

      end

      private

      def create_directories directories
        directories.each { |d| create_directory d }
      end

      def create_directory directory
        CiInACan::FileSystem.create_directory directory
      end

      def create_file file, content
        CiInACan::FileSystem.create_file file, content
      end

    end
  end
end
