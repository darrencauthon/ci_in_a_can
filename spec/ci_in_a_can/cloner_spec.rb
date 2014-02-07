require_relative '../spec_helper'

describe CiInACan::Cloner do

  [:git_ssh, :local_location, :sha].to_objects { [
    ['a', 'b', 'c'],
    ['b', 'a', 'd'],
  ] }.each do |build|

    describe "clone a local copy for" do

      it "should run a bash command to clone the repo" do

        raise 'k'
        CiInACan::Bash.expects(:run).with "git clone #{build.git_ssh} #{build.local_location}; cd #{build.local_location}; git checkout #{build.sha}"

        CiInACan::Cloner.clone_a_local_copy_for build

      end

    end

  end

end
