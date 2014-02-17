require 'subtle'

module CiInACan
  class TestResult

    PERSISTENCE_TYPE = 'test_result'

    params_constructor do
      @created_at = Time.now unless @created_at
    end

    attr_accessor :id
    attr_accessor :passed, :output
    attr_accessor :created_at
    attr_accessor :build_id
    attr_accessor :branch
    attr_accessor :repo

    def self.create values
      test_result = create_the_test_result_from values
      save_this test_result
      test_result
    end

    def self.find id
      CiInACan::Persistence.find PERSISTENCE_TYPE, id
    end

    def to_json
      { 
        id:         id, 
        passed:     passed, 
        output:     output,
        created_at: created_at
      }.to_json
    end
    
    def to_html
      CiInACan::ViewModels::TestResultViewModel.new(self).to_html
    end

    def output_summary
      '2013 tests, 6058 assertions, 0 failures, 0 errors, 0 skips'
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
