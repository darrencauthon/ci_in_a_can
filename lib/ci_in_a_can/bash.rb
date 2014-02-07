require 'open4'

module CiInACan

  module Bash

    def self.run command

      Open4::popen4 command

    end

  end

end
