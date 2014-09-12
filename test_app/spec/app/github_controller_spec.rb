require_relative '../minitest_helper'

describe GithubController do

  let(:params) { {} }

  let(:controller) do
    c = GithubController.new
    c.stubs(:params).returns params
    c
  end

  it "should be an application controller" do
    controller.is_a?(ApplicationController).must_equal true
  end

  describe "receive a github request" do

    it "should start a build" do
      CiInACan::Build.expects(:start).with(params)
      controller.push
    end

  end

end
