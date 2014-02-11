module CiInACan
  class TestResult

    PERSISTENCE_TYPE = 'test_result'

    params_constructor

    attr_accessor :id
    attr_accessor :passed, :output

    def self.create values
      test_result = create_the_test_result_from values
      save_this test_result
      test_result
    end

    def self.find id
      CiInACan::Persistence.find PERSISTENCE_TYPE, id
    end

    private

    def self.create_the_test_result_from values
      self.new values.merge(id: UUID.new.generate)
    end

    def self.save_this test_result
      CiInACan::Persistence.save PERSISTENCE_TYPE, test_result.id, test_result
    end
  end
end
