require_relative '../spec_helper'

describe CiInACan::Github do

  describe "client" do

    it "should create an Octokit client with the access token" do
      access_token = Object.new
      client       = Object.new

      CiInACan::Github.access_token = access_token

      Octokit::Client.expects(:new).with(access_token: access_token).returns client

      CiInACan::Github.client.must_be_same_as client
    end

  end

end
