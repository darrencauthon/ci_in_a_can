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
          next if new_files.count == 0
          CiInACan::Runner.wake_up
        end
      end

    end

  end

end
