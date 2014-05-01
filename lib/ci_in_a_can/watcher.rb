require 'listen'

module CiInACan

  module Watcher

    def self.watch watching_location, working_location
      build_listener(watching_location, working_location).start
    end

    class << self

      private

      def build_listener watching_location, working_location
        callback = build_callback working_location
        ::Listen.to(watching_location, { only: /\.json$/ }, &callback)
      end

      def build_callback working_location
        Proc.new do |_, new_files, _|
          next unless new_files.count > 0
          Runner.process_job_file new_files.first, working_location
        end
      end

      def delete file
        File.delete file
      rescue
      end

      def create_a_build_for file, working_location
      end

    end

  end

end
