require_relative '../spec_helper'

describe CiInACan::Runner do

  describe "run" do

    let(:build) { Object.new }

    before do
      CiInACan::Cloner.stubs(:clone_a_local_copy_for)
      CiInACan::TestRunner.stubs(:run_tests_for)
    end

    it "should clone the git repo" do
      CiInACan::Cloner.expects(:clone_a_local_copy_for).with build
      CiInACan::Runner.run build
    end

    it "should run the tests" do
      CiInACan::TestRunner.expects(:run_tests_for).with build
      CiInACan::Runner.run build
    end

    it "should run the test after the clone" do
      count = 0
      CiInACan::Cloner.stubs(:clone_a_local_copy_for).with { count += 1 }
      CiInACan::TestRunner.stubs(:run_tests_for).with { count.must_equal 1; true }

      CiInACan::Runner.run build
    end

  end

end
