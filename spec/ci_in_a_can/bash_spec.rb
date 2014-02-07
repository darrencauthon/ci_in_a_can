require_relative '../spec_helper'

describe CiInACan::Bash do
  
  describe "run" do

    it "should run the command with open4" do
        
      command = Object.new
      Open4.expects(:popen4).with command

      CiInACan::Bash.run command

    end

  end

end
