module CiInACan
  module BashRunner
    def self.execute command
      `#{command}`
    end
  end
end
