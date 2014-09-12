require_relative '../spec_helper'

describe CiInACan::Build do

  let(:build) { CiInACan::Build.new } 

  describe "start" do

    let(:data) { {} }
    let(:flow) { Object.new }

    it "should start a seam workflow" do
      CiInACan::Build.stubs(:flow_for).with(data).returns flow
      flow.expects(:start).with data
      build.start data
    end

  end

  describe "creating a workflow for data we received from github" do

    let(:data) { Object.new }

    it "should return an instance of a seam workflow" do
      result = CiInACan::Build.flow_for data
      result.is_a?(Seam::Flow).must_equal true
    end

  end

end
