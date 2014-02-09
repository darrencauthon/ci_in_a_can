module CiInACan

  class BashResult

    attr_accessor :exit_code, :output

    def success
      exit_code == 0
    end

  end

end
