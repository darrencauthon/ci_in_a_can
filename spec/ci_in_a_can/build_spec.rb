require_relative '../spec_helper'

describe CiInACan::Build do

  after do
    Timecop.return
  end

  it "should default created_at to the current date" do
    now = Time.now
    ::Timecop.freeze now
    CiInACan::Build.new.created_at.must_equal now
  end

  it "should allow the created_at to be set" do
    now = Object.new
    build = CiInACan::Build.new(created_at: now)
    build.created_at.must_be_same_as now
  end

  describe "commands" do

    describe "when no build settings exist for the build" do

      let(:build) { CiInACan::Build.new }

      before do
        CiInACan::BuildSetting.stubs(:commands_for).with(build).returns []
      end

      it "should default commands to the basic ruby conventions" do
        result = build.commands
        result.count.must_equal 2
        result[0].must_equal 'bundle install'
        result[1].must_equal 'bundle exec rake'
      end

    end

    describe "when a build setting exists" do

      let(:build) { CiInACan::Build.new }
      let(:commands_for_build) { [Object.new] }

      before do
        CiInACan::BuildSetting.stubs(:commands_for)
                              .with(build)
                              .returns commands_for_build
      end

      it "should return those commands" do
        build.commands.must_be_same_as commands_for_build
      end

    end

  end

  describe "parse" do

    it "should return the result of the Github parser" do
      content = Object.new
      parser  = Object.new
      build   = Object.new

      parser.stubs(:parse).with(content).returns build
      CiInACan::GithubBuildParser.stubs(:new).returns parser

      CiInACan::Build.parse(content).must_be_same_as build
    end

  end

end
