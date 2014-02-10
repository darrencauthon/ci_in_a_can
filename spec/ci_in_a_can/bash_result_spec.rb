require_relative '../spec_helper'

describe CiInACan::BashResult do

  describe "successful" do

    let(:bash_result) { CiInACan::BashResult.new }

    it "should return true if the exit code is 0" do
      bash_result.exit_code = 0
      bash_result.successful.must_equal true
    end

    it "should return false if the exit code is not 0" do
      bash_result.exit_code = 1
      bash_result.successful.must_equal false
    end

  end

end
