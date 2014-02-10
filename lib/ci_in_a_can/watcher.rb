require 'listen'
require 'json'

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
        Proc.new do |modified, added, removed|
          next unless added.count > 0

          build = CiInACan::Build.parse File.read(added.first)
          build.id = UUID.new.generate
          build.local_location = "#{working_location}/#{build.id}"

          Runner.run build
        end
      end

    end

  end

end
