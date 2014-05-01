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

  describe "creating for a file" do

    let(:file)             { Object.new }
    let(:file_contents)    { Object.new }
    let(:working_location) { "a" }

    before do
      File.stubs(:read).with(file).returns file_contents
      CiInACan::Build.stubs(:parse).returns CiInACan::Build.new
    end

    it "should return a build parsed from the file contents" do

      expected_build = CiInACan::Build.new

      CiInACan::Build.stubs(:parse)
                     .with(file_contents)
                     .returns expected_build

      build = CiInACan::Build.create_for file, working_location

      build.must_be_same_as expected_build
        
    end

    [
      ['a', '1234'],
      ['b', '5678'],
    ].map { |x| Struct.new(:working_location, :unique_identifier).new(*x) }.each do |example|

      describe "details" do

        let(:working_location) { example.working_location }

        it "should set the id to a new UUID" do
          uuid = Object.new
          UUID.stubs(:new).returns uuid
          uuid.stubs(:generate).returns example.unique_identifier

          build = CiInACan::Build.create_for file, working_location

          build.id.must_equal example.unique_identifier
            
        end

        it "should set the local location" do
          uuid = Object.new
          UUID.stubs(:new).returns uuid
          uuid.stubs(:generate).returns example.unique_identifier

          build = CiInACan::Build.create_for file, working_location

          build.local_location.must_equal "#{example.working_location}/#{example.unique_identifier}"
        end

      end

    end

  end

  describe "commands" do

    let(:repo_name) { Object.new }
    let(:repo)      { CiInACan::Repo.new }

    let(:build) do
      b = CiInACan::Build.new
      b.repo = repo_name
      b
    end

    before do
      CiInACan::Repo.stubs(:find).with(repo_name).returns repo
    end

    describe "when no build settings exist for the build" do

      before do
        repo.stubs(:build_commands).returns []
      end

      it "should default commands to the basic ruby conventions" do
        result = build.commands
        result.count.must_equal 2
        result[0].must_equal 'bundle install'
        result[1].must_equal 'bundle exec rake'
      end

    end

    describe "when a build setting exists" do

      let(:commands_for_build) { [Object.new] }

      before do
        repo.stubs(:build_commands).returns commands_for_build
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
