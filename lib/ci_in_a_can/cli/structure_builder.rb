module CiInACan

  module Cli

    class StructureBuilder

      params_constructor

      attr_accessor :root, :id

      def create
        directories_to_create = [@root, "#{@root}/jobs", "#{@root}/repos", "#{@root}/web", "#{@root}/service", "#{@root}/results"]

        directories_to_create.each { |d| create_directory d }

        files = ::CiInACan::Cli::Files.for @id, @root

        create_file "#{@root}/Rakefile", files.rake_file
        create_file "#{@root}/service/service.rb", files.service_file
        create_file "#{@root}/web/stay_alive.rb", files.web_daemon
        create_file "#{@root}/web/config.ru", files.web_file
      end

      private

      def create_directory directory
        Dir.mkdir(directory) unless File.exists?(directory)
      end

      def create_file file, content
        File.open(file, 'w') { |f| f.write content }
      end

    end
  end
end
