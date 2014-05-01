require_relative '../spec_helper'

describe CiInACan::Cleaner do

  describe "removing a local copy of a build" do

    ['a', 'b'].each do |local_location|

      describe "different locations" do

        it "should exist" do
          build = CiInACan::Build.new(local_location: local_location)
          CiInACan::Bash.expects(:run).with("rm -rf \"#{local_location}\"")
          CiInACan::Cleaner.remove_local_copy_of build
        end

      end

    end

  end

end
