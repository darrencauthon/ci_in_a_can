require_relative '../spec_helper'

describe CiInACan::Build do

  it "should default commands to an empty array" do
    result = CiInACan::Build.new.commands
    result.count.must_equal 0
    result.is_a?(Array).must_equal true
  end

  [:compare, :sha, :git_ssh, :repo].to_objects {[
    ["https://github.com/darrencauthon/ci_in_a_can/commit/b1c5f9c9588f", "qwe", "git@github.com:darrencauthon/ci_in_a_can.git", "darrencauthon/ci_in_a_can"],
    ["https://github.com/abc/123/commit/b1c5f9c9588f",                   "uio", "git@github.com:abc/123.git",                   "abc/123"]
  ]}.each do |test|

    describe "parse" do

      let(:content) do
        {
          payload: {
                     compare:     test.compare,
                     head_commit: { id: test.sha }
                   }.to_json
        }.to_json
      end

      it "should convert the http to a git ssh" do
        build = CiInACan::Build.parse content
        build.git_ssh.must_equal test.git_ssh
      end

      it "should return the repo" do
        build = CiInACan::Build.parse content
        build.repo.must_equal test.repo
      end

      it "should stamp the sha" do
        build = CiInACan::Build.parse content
        build.sha.must_equal test.sha
      end

    end

  end

end
