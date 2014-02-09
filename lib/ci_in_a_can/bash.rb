module CiInACan

  class Bash

    attr_accessor :exit_code, :output

    def self.run command

      result = self.new
      result.output    = backtick command
      result.exit_code = the_exit_code
      result

    end

    def self.backtick command
      `#{command}`
    end

    def self.the_exit_code
      $?.to_i
    end

  end

end
