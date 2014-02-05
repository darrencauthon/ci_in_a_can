require 'listen'
require 'json'

module CiInACan

  module Watcher

    def self.watch
      listener = ::Listen.to('.') do |modified, added, removed|
        return unless added.count > 0
        json = File.read added.first
        data = JSON.parse(json)['payload']
        Runner.run data
      end
      listener.start
    end

  end

end
