require_relative '../spec_helper'

describe CiInACan::Build do

  let(:build) { CiInACan::Build.new } 

  describe "start" do

    let(:data) { {} }
    let(:flow) { Object.new }

    it "should start a seam workflow" do
      CiInACan::Build.stubs(:flow).returns flow
      flow.expects(:start)
      build.start data
    end

  end

end
