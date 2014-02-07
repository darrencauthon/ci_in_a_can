require_relative '../spec_helper'

describe CiInACan::Watcher do

  describe "watch" do

    let(:watching_location) { Object.new }

    describe "it should build the listener and start it" do

      it "should start the listener" do

        listener = Object.new
        CiInACan::Watcher.stubs(:build_listener).with(watching_location).returns listener

        listener.expects(:start)

        CiInACan::Watcher.watch watching_location
          
      end

    end


  end

  describe "building a listener" do

    let(:watching_location) { Object.new }

    it "should return a listener with the appropriate callback" do

      expected_result = Object.new
      callback        = Proc.new { expected_result }
      
      CiInACan::Watcher.stubs(:build_callback).returns callback

      ::Listen.expects(:to).with(watching_location, { only: /\.json$/ }, &callback)

      CiInACan::Watcher.build_listener watching_location
    end

  end

end
