require_relative '../spec_helper'

describe CiInACan::Cloner do

  [:git_ssh, :local_location].to_objects { [
    ['a', 'b'],
    ['b', 'a'],
  ] }.each do |build|

    describe "clone a local copy for" do

      it "should run a bash command to clone the repo" do

        CiInACan::Bash.expects(:run).with "git clone #{build.git_ssh} #{build.local_location}"

        CiInACan::Cloner.clone_a_local_copy_for build

      end

    end

  end

end
