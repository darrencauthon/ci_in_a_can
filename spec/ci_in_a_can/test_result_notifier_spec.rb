require_relative '../spec_helper'

describe CiInACan::TestResultNotifier do

  describe 'send for' do

    let(:build)       { CiInACan::Build.new }
    let(:test_result) { CiInACan::TestResult.new }

    it "should mark passing tests as success in github" do

      test_result.passed = true

      build.sha  = Object.new
      build.repo = Object.new

      client = Object.new
      CiInACan::Github.stubs(:client).returns client

      client.expects(:create_status).with(build.repo, build.sha, "success")

      CiInACan::TestResultNotifier.send_for build, test_result
    end

    it "should mark failing tests as failure in github" do

      test_result.passed = false

      build.sha  = Object.new
      build.repo = Object.new

      client = Object.new
      CiInACan::Github.stubs(:client).returns client

      client.expects(:create_status).with(build.repo, build.sha, "failure")

      CiInACan::TestResultNotifier.send_for build, test_result
    end

  end

end
