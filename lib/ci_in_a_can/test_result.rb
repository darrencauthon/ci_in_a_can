require 'subtle'

module CiInACan
  class TestResult
    params_constructor
    attr_accessor :id
    attr_accessor :passed, :output

    def self.create values
      test_result = self.new values
      test_result.id = UUID.new.generate
      CiInACan::Persistence.save "test_result", test_result.id, test_result
      test_result
    end

    def self.find id
      CiInACan::Persistence.find "test_result", id
    end
  end
end
