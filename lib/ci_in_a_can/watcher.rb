require 'listen'
require 'json'

module CiInACan

  module Watcher

    def self.watch watching_location, working_location
      build_listener(watching_location, working_location).start
    end

    def self.build_callback working_location
      Proc.new do |modified, added, removed|
        next unless added.count > 0
        content = File.read added.first
        build = CiInACan::Build.parse content
        build.local_location = working_location
        Runner.run build
      end
    end

    def self.build_listener watching_location, working_location
      callback = build_callback working_location
      ::Listen.to(watching_location, { only: /\.json$/ }, &callback)
    end

  end

end
