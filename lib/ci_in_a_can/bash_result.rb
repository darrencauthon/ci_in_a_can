module CiInACan

  class BashResult

    attr_accessor :exit_code, :output

    def successful
      exit_code == 0
    end

  end

end
