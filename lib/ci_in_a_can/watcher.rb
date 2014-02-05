require 'listen'
require 'json'

module CiInACan

  module Watcher

    def self.watch
      listener = ::Listen.to('.', only: /\.json$/) do |modified, added, removed|
        return unless added.count > 0
        json = File.read added.first
        data = JSON.parse(JSON.parse(json)['payload'])
        data['unique_location'] = UUID.new.generate
        Runner.run data
      end
      listener.start
    end

  end

end
