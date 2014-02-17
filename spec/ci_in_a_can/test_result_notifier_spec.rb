require_relative '../spec_helper'

describe CiInACan::TestResultNotifier do

  describe 'send for' do

    let(:build)       { CiInACan::Build.new }
    let(:test_result) { CiInACan::TestResult.new }

    before do
      CiInACan::Run.stubs(:add)
      CiInACan::Github.stubs(:report_complete_status_for)
    end

    it "should mark the results in github" do

      test_result.passed = true

      build.sha  = Object.new
      build.repo = Object.new

      CiInACan::Github.expects(:report_complete_status_for).with build, test_result

      CiInACan::TestResultNotifier.send_for build, test_result
    end

    it "should add the build and test result to the last run list" do
      CiInACan::Run.expects(:add).with build, test_result
      CiInACan::TestResultNotifier.send_for build, test_result
    end

  end

end
