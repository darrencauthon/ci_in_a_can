require 'subtle'
require 'yaml/store'

module CiInACan
  class TestResult
    params_constructor
    attr_accessor :id
    attr_accessor :passed, :output

    def self.create values
      values[:id] = UUID.new.generate
      @saved = self.new values
    end

    def self.find id
      @saved
    end
  end
end
