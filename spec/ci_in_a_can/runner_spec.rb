require_relative '../spec_helper'

describe CiInACan::Runner do

  describe "wake up" do
    it "should this should fire off a separate process that will read one file from the jobs folder" do
      raise 'this does not exist yet.'
    end
  end

  describe "run" do

    let(:build)  { CiInACan::Build.new }

    before do
      CiInACan::Github.stubs(:report_pending_status_for)
      CiInACan::Cloner.stubs(:clone_a_local_copy_for)
      CiInACan::TestRunner.stubs(:run_tests_for)
      CiInACan::TestResultNotifier.stubs(:send_for)
      CiInACan::Cleaner.stubs(:remove_local_copy_of)
    end

    it "should clone the git repo" do
      CiInACan::Cloner.expects(:clone_a_local_copy_for).with build
      CiInACan::Runner.run build
    end

    it "should run the tests" do
      CiInACan::TestRunner.expects(:run_tests_for).with build
      CiInACan::Runner.run build
    end
    
    it "should cleanup after itself" do
      CiInACan::Cleaner.expects(:remove_local_copy_of).with build
      CiInACan::Runner.run build
    end

    it "should run the test after the clone" do
      count = 0
      CiInACan::Cloner.stubs(:clone_a_local_copy_for).with { count += 1 }
      CiInACan::TestRunner.stubs(:run_tests_for).with { count.must_equal 1; true }

      CiInACan::Runner.run build
    end

    it "should cleanup after the test results are retrieved" do
      count = 0
      CiInACan::TestRunner.stubs(:run_tests_for).with { count += 1 }
      CiInACan::Cleaner.stubs(:remove_local_copy_of).with { count.must_equal 1; true }

      CiInACan::Runner.run build
    end

    it "should call the test result notifier with the build and the results" do
      test_results = Object.new
      CiInACan::TestRunner.stubs(:run_tests_for).with(build).returns test_results

      CiInACan::TestResultNotifier.expects(:send_for).with build, test_results

      CiInACan::Runner.run build
    end

    it "should send a pending notification to github" do

      build.repo = Object.new
      build.sha  = Object.new
      CiInACan::Github.expects(:report_pending_status_for).with build

      CiInACan::Runner.run build
    end

  end

  describe "process job file" do

    let(:file)             { Object.new }
    let(:working_location) { Object.new }
    let(:build)            { Object.new }

    before do
      CiInACan::Build.stubs(:create_for).returns build
      CiInACan::Runner.stubs(:run).with build
    end

    it "should create a build for the file and run it" do
      CiInACan::Build.stubs(:create_for).with(file, working_location).returns build
      CiInACan::Runner.expects(:run).with build
      CiInACan::Runner.process_job_file file, working_location
    end

    it "should delete the file" do
      File.expects(:delete).with file
      CiInACan::Runner.process_job_file file, working_location
    end

    it "should delete the file after the build has been created" do
      File.expects(:delete).with do |file|
        CiInACan::Build.stubs(:create_for).raises 'deleted too early'
        true
      end
      CiInACan::Runner.process_job_file file, working_location
    end
  end

end
