module CiInACan
  class Build
    def start data
      CiInACan::Build.flow_for(data).start data
    end
  end
end
