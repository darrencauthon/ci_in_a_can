require_relative '../spec_helper'

describe CiInACan::TestRunner do

  describe "create" do
    it "should set a unique id" do
      id   = Object.new
      uuid = Object.new

      UUID.stubs(:new).returns uuid
      uuid.expects(:generate).returns id

      test_result = CiInACan::TestResult.create({})

      test_result.id.must_be_same_as id
    end
  end

  describe "create and find" do

    describe "a simple example" do

      it "should be able to store and retrieve a result" do

        original_test_result  = CiInACan::TestResult.create({})
        retrieved_test_result = CiInACan::TestResult.find original_test_result.id

        original_test_result.id.must_equal retrieved_test_result.id

      end

      it "should be persist values" do

        values = { passed: true, output: 'some output' }
        original_test_result  = CiInACan::TestResult.create(values)
        retrieved_test_result = CiInACan::TestResult.find original_test_result.id

        retrieved_test_result.contrast_with! values

      end

    end

    describe "a more complicated example" do

      it "should be able to store and retrieve a result" do

        # save more records
        CiInACan::TestResult.create({})
        CiInACan::TestResult.create({})
        original_test_result  = CiInACan::TestResult.create({})
        CiInACan::TestResult.create({})
        CiInACan::TestResult.create({})

        retrieved_test_result = CiInACan::TestResult.find original_test_result.id

        original_test_result.id.must_equal retrieved_test_result.id

      end

    end

  end

end
