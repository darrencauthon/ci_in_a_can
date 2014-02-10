require_relative '../spec_helper'

describe CiInACan::Github do

  describe "client" do

    describe "when an access token was provided" do

      let(:access_token) { Object.new }

      it "should create an Octokit client with the access token" do
        client       = Object.new

        CiInACan::Github.access_token = access_token

        Octokit::Client.expects(:new).with(access_token: access_token).returns client

        CiInACan::Github.client.must_be_same_as client
      end

    end

    describe "when an access token was not provided" do

      let(:access_token) { nil }

      it "should return nothing" do
        CiInACan::Github.access_token = access_token

        Octokit::Client.expects(:new).never

        CiInACan::Github.client.nil?.must_equal true
      end

    end

  end

end
