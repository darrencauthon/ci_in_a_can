require_relative '../spec_helper'

describe CiInACan::Watcher do

  before do
    File.stubs(:delete)
  end

  describe "watch" do

    let(:watching_location) { Object.new }
    let(:working_location)  { Object.new }

    describe "it should build the listener and start it" do

      it "should start the listener" do

        listener = Object.new
        CiInACan::Watcher.stubs(:build_listener)
                         .with(watching_location, working_location)
                         .returns listener

        listener.expects(:start)

        CiInACan::Watcher.watch watching_location, working_location
          
      end

    end

  end

  describe "building a listener" do

    let(:watching_location) { Object.new }
    let(:working_location)  { Object.new }

    it "should return a listener with the appropriate callback" do

      expected_result = Object.new
      callback        = Proc.new { expected_result }
      
      CiInACan::Watcher.stubs(:build_callback)
                       .with(working_location)
                       .returns callback

      ::Listen.expects(:to).with(watching_location, { only: /\.json$/ }, &callback)

      CiInACan::Watcher.send(:build_listener, watching_location, working_location)
    end

  end

  describe "build a callback that will initiate the job runner" do

    let(:working_location) { Object.new }

    it "should return a Proc" do
      CiInACan::Runner.stubs(:wake_up)
      CiInACan::Watcher.send(:build_callback, nil).is_a? Proc
    end

    describe "when a file is added" do

      let(:added_file) { Object.new }

      it "wake up the runner" do
        CiInACan::Runner.expects(:wake_up)
        CiInACan::Watcher.send(:build_callback, nil).call [], [added_file], []
      end

    end

    describe "when a file is not added" do

      it "should not wake up the runner" do
        CiInACan::Runner.expects(:wake_up).never
        CiInACan::Watcher.send(:build_callback, nil).call [], [], []
      end

    end

  end

end
