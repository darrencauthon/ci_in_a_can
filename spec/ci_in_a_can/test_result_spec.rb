require_relative '../spec_helper'

describe CiInACan::TestRunner do

  describe "create and find" do

    it "should store the result" do

      values = { passed: true, output: "some output" }

      original_test_result  = CiInACan::TestResult.create values
      retrieved_test_result = CiInACan::TestResult.find original_test_result.id

      original_test_result.id.must_equal retrieved_test_result.id

    end

    it "should set a unique id" do
      id   = Object.new
      uuid = Object.new

      UUID.stubs(:new).returns uuid
      uuid.expects(:generate).returns id

      test_result  = CiInACan::TestResult.create({})

      test_result.id.must_be_same_as id
    end

  end

end
