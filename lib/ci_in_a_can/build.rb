module CiInACan

  class Build

    def self.flow_for data
      Seam::Flow.new
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
