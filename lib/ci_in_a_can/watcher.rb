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

          File.delete new_files.first

          build = create_a_build_for(new_files.first, working_location)

          Runner.run build

        end
      end

      def create_a_build_for file, working_location
        build = CiInACan::Build.parse File.read(file)
        build.id = UUID.new.generate
        build.local_location = "#{working_location}/#{build.id}"
        build
      end

    end

  end

end
