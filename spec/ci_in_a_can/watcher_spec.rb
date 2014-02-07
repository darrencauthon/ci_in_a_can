require_relative '../spec_helper'

describe CiInACan::Watcher do

  describe "watch" do

    let(:working_location) { Object.new }

    describe "it should build the listener and start it" do

      it "should start the listener" do

        listener = Object.new
        CiInACan::Watcher.stubs(:build_listener).with(working_location).returns listener

        listener.expects(:start)

        CiInACan::Watcher.watch working_location
          
      end

    end


  end

end
