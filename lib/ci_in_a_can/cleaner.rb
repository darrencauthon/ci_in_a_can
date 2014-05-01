module CiInACan
  module Cleaner
    def self.remove_local_copy_of build
      CiInACan::Bash.run "rm -rf #{build.local_location}"
    end
  end
end
