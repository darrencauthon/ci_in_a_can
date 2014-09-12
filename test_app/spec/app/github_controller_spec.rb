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

    let(:parser)         { Object.new }
    let(:parsed_payload) { Object.new }

    before do
      CiInACan::GithubPayloadParser.stubs(:new).returns parser
      parser.stubs(:parse).with(params).returns parsed_payload

      CiInACan::Build.stubs(:start)
      controller.stubs(:render)
    end

    it "should start a build" do
      CiInACan::Build.expects(:start).with(parsed_payload)
      controller.push
    end

    it "should return an empty json response" do
      controller.expects(:render).with(json: {})
      controller.push
    end

  end

end
