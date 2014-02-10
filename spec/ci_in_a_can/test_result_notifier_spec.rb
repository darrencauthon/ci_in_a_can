require_relative '../spec_helper'

describe CiInACan::TestResultNotifier do

  describe 'send for' do

    let(:build)       { CiInACan::Build.new }
    let(:test_result) { CiInACan::TestResult.new }

    it "should mark the results in github" do

      test_result.passed = true

      build.sha  = Object.new
      build.repo = Object.new

      CiInACan::Github.expects(:report_complete_status_for).with build, test_result

      CiInACan::TestResultNotifier.send_for build, test_result
    end

  end

end
