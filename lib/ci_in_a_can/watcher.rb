require 'listen'
require 'json'

module CiInACan

  module Watcher

    def self.build_listener working_location
      ::Listen.to(working_location, { only: /\.json$/ }, &build_callback)
    end

    def self.watch working_location
      listener = build_listener working_location
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
