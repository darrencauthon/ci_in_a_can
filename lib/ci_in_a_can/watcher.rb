require 'listen'
require 'json'

module CiInACan

  module Watcher

    def self.build_callback working_location
      Proc.new do |modified, added, removed|
        next unless added.count > 0
        #next if added.first.include? working_location
        #puts added.first
        content = File.read added.first
        #data = JSON.parse(JSON.parse(json)['payload'])
        #data['unique_location'] = UUID.new.generate
        build = CiInACan::Build.parse content
        build.local_location = working_location
        Runner.run build
      end
    end

    def self.build_listener watching_location, working_location
      callback = build_callback working_location
      ::Listen.to(watching_location, { only: /\.json$/ }, &callback)
    end

    def self.watch watching_location, working_location
      listener = build_listener watching_location, working_location
      listener.start
      #working_location = File.expand_path(File.dirname(__FILE__))
      #working_location.gsub!('/lib/ci_in_a_can', '')
      #working_location += '/temp'
      #puts working_location
      #listener = ::Listen.to('.', only: /\.json$/) do |modified, added, removed|
        #next unless added.count > 0
        #next if added.first.include? working_location
        #puts added.first
        #json = File.read added.first
        #data = JSON.parse(JSON.parse(json)['payload'])
        #data['unique_location'] = UUID.new.generate
        #Runner.run data
      #end
      #listener.start
    end

  end

end
