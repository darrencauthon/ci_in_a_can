require 'listen'

module CiInACan

  module Watcher

    def self.watch
      listener = ::Listen.to('.') do |modified, added, removed|
        return unless added.count > 0
        puts "added absolute path: #{added}"
      end
      listener.start
    end

  end

end
