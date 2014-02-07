require_relative '../spec_helper'

describe CiInACan::Watcher do

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

  describe "build a callback" do

    let(:working_location) { Object.new }

    it "should return a Proc" do
      CiInACan::Watcher.send(:build_callback, nil).is_a? Proc
    end

    it "should the proc can take three arrays" do
      CiInACan::Watcher.send(:build_callback, nil).call [], [], []
    end

    describe "when a file is added" do

      let(:added_file) { Object.new }
      let(:build)      { CiInACan::Build.new }

      before do
        content    = Object.new

        File.stubs(:read).with(added_file).returns content

        CiInACan::Build.stubs(:parse).with(content).returns build

        CiInACan::Runner.stubs(:run).with build
      end

      it "should open the file, parse a build from it, and run it" do
        CiInACan::Runner.expects(:run).with build
        CiInACan::Watcher.send(:build_callback, nil).call [], [added_file], []
      end

      it "should assign the local location on the build" do

        working_location = Object.new
        CiInACan::Runner.stubs(:wl).returns working_location

        CiInACan::Runner.expects(:run).with do |b|
          b.local_location.must_be_same_as CiInACan::Runner.wl
          true
        end

        CiInACan::Watcher.send(:build_callback, working_location).call [], [added_file], []
      end

    end

  end

end
