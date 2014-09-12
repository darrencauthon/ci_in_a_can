require_relative '../spec_helper'

describe CiInACan::Build do

  describe "start" do

    let(:data) { {} }
    let(:flow) { Object.new }

    it "should start a seam workflow" do
      CiInACan::Build.stubs(:flow_for).with(data).returns flow
      flow.expects(:start).with data
      CiInACan::Build.start data
    end

  end

  describe "creating a workflow for data we received from github" do

    let(:data) { Object.new }

    it "should return an instance of a seam workflow" do
      result = CiInACan::Build.flow_for data
      result.is_a?(Seam::Flow).must_equal true
    end

    it "should have the steps I think we need right now" do
      result = CiInACan::Build.flow_for data
      steps = result.steps
      steps.count.must_equal 4
      steps[0].name.must_equal "clone_the_github_repo_to_a_local_directory"
      steps[1].name.must_equal "run_any_common_setup_commands"
      steps[2].name.must_equal "run_the_tests"
      steps[3].name.must_equal "report_the_test_results_back_to_github"
    end

  end

end
