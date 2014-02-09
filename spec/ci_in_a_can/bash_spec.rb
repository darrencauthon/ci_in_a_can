require_relative '../spec_helper'

describe CiInACan::Bash do
  
  describe "run" do

    let(:command)   { Object.new }
    let(:output)    { Object.new }
    let(:exit_code) { Object.new }

    before do
      CiInACan::Bash.stubs(:backtick).with(command).returns output
      CiInACan::Bash.stubs(:the_exit_code).returns exit_code
    end

    it "should return a BashResult" do
      result = CiInACan::Bash.run command
      result.is_a?(CiInACan::BashResult).must_equal true
    end

    it "should return the output" do
      result = CiInACan::Bash.run command
      result.output.must_be_same_as output
    end

    it "should return the exit code" do
      result = CiInACan::Bash.run command
      result.exit_code.must_be_same_as exit_code
    end


  end

end
