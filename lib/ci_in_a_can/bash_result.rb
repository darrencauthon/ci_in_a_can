module CiInACan

  class BashResult

    params_constructor

    attr_accessor :exit_code, :output

    def successful
      exit_code == 0
    end

  end

end
