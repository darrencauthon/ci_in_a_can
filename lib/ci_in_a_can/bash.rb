module CiInACan

  module Bash

    def self.run command
      CiInACan::BashResult.new(output:    backtick(command),
                               exit_code: the_exit_code)
    end

    def self.backtick command
      `#{command}`
    end

    def self.the_exit_code
      $?.to_i
    end

  end

end
