require_relative '../spec_helper'

describe CiInACan::GithubBuildParser do

  [:branch, :ref, :compare, :sha, :git_ssh, :repo].to_objects {[
    ["blah",              "refs/heads/blah",          "https://github.com/darrencauthon/ci_in_a_can/commit/b1c5f9c9588f", "qwe", "git@github.com:darrencauthon/ci_in_a_can.git", "darrencauthon/ci_in_a_can"],
    ["bloo",              "refs/heads/bloo",          "https://github.com/abc/123/commit/b1c5f9c9588f",                   "uio", "git@github.com:abc/123.git",                   "abc/123"],
    ["issues/5/blop",     "refs/heads/issues/5/blop", "https://github.com/abc/123/commit/b1c5f9c9588f",                   "uio", "git@github.com:abc/123.git",                   "abc/123"],
    ["v0.0.22",           "refs/tags/v0.0.22",        "https://github.com/abc/123/commit/b1c5f9c9588f",                   "uio", "git@github.com:abc/123.git",                   "abc/123"]
  ]}.each do |test|

    describe "parse" do

      # content is a representation of the web request
      # that github will send on every push
      let(:content) do
        {
          payload: {
                     compare:     test.compare,
                     head_commit: { id: test.sha },
                     ref:         test.ref
                   }.to_json
        }.to_json
      end

      it "should convert the http to a git ssh" do
        build = CiInACan::GithubBuildParser.new.parse content
        build.git_ssh.must_equal test.git_ssh
      end

      it "should return the repo" do
        build = CiInACan::GithubBuildParser.new.parse content
        build.repo.must_equal test.repo
      end

      it "should stamp the sha" do
        build = CiInACan::GithubBuildParser.new.parse content
        build.sha.must_equal test.sha
      end

      it "should stamp the branch" do
        build = CiInACan::GithubBuildParser.new.parse content
        build.branch.must_equal test.branch
      end

    end

  end

end

