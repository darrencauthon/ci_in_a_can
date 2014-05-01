module CiInACan

  module Runner

    def self.process_job_file file, working_location
      build = Build.create_for file, working_location
      delete file
      Runner.run build
    end

    def self.run build
      report_pending_status_for build
      clone_a_local_copy_of build
      test_results = run_the_tests_for build
      CiInACan::Cleaner.remove_local_copy_of build
      send_notifications_for build, test_results
    end

    private

    def self.delete file
      File.delete file
    rescue
    end

    def self.send_notifications_for build, test_results
      CiInACan::TestResultNotifier.send_for build, test_results
    end

    def self.run_the_tests_for build
      CiInACan::TestRunner.run_tests_for build
    end

    def self.report_pending_status_for build
      CiInACan::Github.report_pending_status_for build
    end

    def self.clone_a_local_copy_of build
      CiInACan::Cloner.clone_a_local_copy_for build
    end

  end

end
