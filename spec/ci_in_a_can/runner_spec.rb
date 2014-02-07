require_relative '../spec_helper'

describe CiInACan::Runner do

  describe "run" do

    let(:build) { Object.new }

    it "should clone the git repo" do
      CiInACan::Cloner.expects(:clone_a_local_copy_for).with build
      CiInACan::Runner.run build
    end

  end

end
