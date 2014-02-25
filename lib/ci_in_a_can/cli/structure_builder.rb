module CiInACan

  module Cli

    class StructureBuilder

      params_constructor

      attr_accessor :root, :id

      def create
        create_the_directories
        create_the_files
      end

      private

      def create_the_directories
        create_directories directories_to_create
      end

      def create_the_files
        files_to_create.each { |file, content| create_file file, content }
      end

      def directories_to_create
        ["#{@root}",
         "#{@root}/jobs",
         "#{@root}/repos",
         "#{@root}/web",
         "#{@root}/service",
         "#{@root}/results"]
      end

      def files_to_create
        files = ::CiInACan::Cli::Files.for @id, @root
        {
          "#{@root}/Rakefile"           => files.rake_file,
          "#{@root}/service/service.rb" => files.service_file,
          "#{@root}/web/stay_alive.rb"  => files.web_daemon,
          "#{@root}/web/config.ru"      => files.web_file
        }
      end

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
