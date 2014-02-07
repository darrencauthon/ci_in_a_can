require_relative '../spec_helper'

describe CiInACan::Build do

  [:compare, :git_ssh].to_objects {[
    ["https://github.com/darrencauthon/ci_in_a_can/commit/b1c5f9c9588f", "git@github.com:darrencauthon/ci_in_a_can.git"],
    ["https://github.com/abc/123/commit/b1c5f9c9588f",                   "git@github.com:abc/123.git"]
  ]}.each do |test|

    describe "parse" do

      let(:content) do
        {
          payload: {
                     compare: test.compare
                   }
        }.to_json
      end

      it "should convert the http to a git ssh" do
        build = CiInACan::Build.parse content
        build.git_ssh.must_equal test.git_ssh
      end

    end

  end

end
