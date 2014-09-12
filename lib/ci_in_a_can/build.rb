module CiInACan

  class Build

    def self.flow_for data
      flow = Seam::Flow.new
      flow.clone_the_github_repo_to_a_local_directory
      flow.run_any_common_setup_commands
      flow.run_the_tests
      flow.report_the_test_results_back_to_github
      flow
    end

    def start data
      workflow = create_a_workflow_considering data
      start_the_workflow workflow, data
    end

    private
    
    def create_a_workflow_considering data
      CiInACan::Build.flow_for data
    end

    def start_the_workflow flow, data
      flow.start data
    end

  end

end
