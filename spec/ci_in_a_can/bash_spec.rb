require_relative '../spec_helper'

describe CiInACan::Bash do
  
  describe "run" do

    it "should run the command with system and return the result" do
        
      expected_result = Object.new
      command         = Object.new

      CiInACan::Bash.stubs(:system).with(command).returns expected_result

      CiInACan::Bash.run(command).must_be_same_as expected_result

    end

  end

end
