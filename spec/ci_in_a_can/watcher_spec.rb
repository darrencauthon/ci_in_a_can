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

      [:working_location, :random_string].to_objects {[
        ["abc", "123"],
        ["123", "abc"],
      ]}.each do |test|

        describe "setting the local location" do

          it "should assign the local location on the build, and the id" do

            CiInACan::Runner.stubs(:wl).returns test.working_location

            uuid = Object.new
            uuid.stubs(:generate).returns test.random_string
            UUID.stubs(:new).returns uuid

            CiInACan::Runner.expects(:run).with do |b|
              b.local_location.must_equal "#{test.working_location}/#{test.random_string}"
              b.id.must_equal test.random_string
              true
            end

            CiInACan::Watcher.send(:build_callback, test.working_location).call [], [added_file], []
          end

          it "should delete the file" do

            CiInACan::Runner.stubs(:wl).returns test.working_location

            uuid = Object.new
            uuid.stubs(:generate).returns test.random_string
            UUID.stubs(:new).returns uuid
            CiInACan::Runner.stubs(:run)

            File.expects(:delete).with added_file

            CiInACan::Watcher.send(:build_callback, test.working_location).call [], [added_file], []
          end

          it "should not delete the file before it is read" do

            content = Object.new
            CiInACan::Runner.stubs(:wl).returns test.working_location

            uuid = Object.new
            uuid.stubs(:generate).returns test.random_string
            UUID.stubs(:new).returns uuid
            CiInACan::Runner.stubs(:run)

            CiInACan::Build.stubs(:parse).with(content).returns build

            delete_called = false
            File.expects(:read).with do |added_file|
              delete_called.must_equal false
              true
            end.returns content

            File.expects(:delete).with do |added_file|
              delete_called = true
              true
            end

            CiInACan::Watcher.send(:build_callback, test.working_location).call [], [added_file], []
          end

          it "should not let an error in deleting a file bubble up" do

            CiInACan::Runner.stubs(:wl).returns test.working_location

            uuid = Object.new
            uuid.stubs(:generate).returns test.random_string
            UUID.stubs(:new).returns uuid
            CiInACan::Runner.stubs(:run)

            File.stubs(:delete).raises 'k'

            # this should not throw
            CiInACan::Watcher.send(:build_callback, test.working_location).call [], [added_file], []
          end

        end

      end

    end

  end

end
