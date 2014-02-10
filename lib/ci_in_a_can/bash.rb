module CiInACan

  module Bash

    def self.run command
      result = CiInACan::BashResult.new
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
