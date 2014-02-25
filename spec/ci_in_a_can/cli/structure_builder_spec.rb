require_relative '../../spec_helper'

describe CiInACan::Cli::StructureBuilder do

  it "should have a root id and an id" do
    id   = Object.new
    root = Object.new
    builder = CiInACan::Cli::StructureBuilder.new(id: id, root: root)
    builder.id.must_be_same_as id
    builder.root.must_be_same_as root
  end

  [:id, :root].to_objects {[
    [nil, 'b'],
    [nil, 'c']
  ]}.each do |data|

    describe "create" do

      let(:builder) do
        b = CiInACan::Cli::StructureBuilder.new(id: data.id, root: data.root)
        b.stubs(:create_directories)
        b
      end

      let(:files) do
        f = Object.new
        f.stubs(:rake_file).returns Object.new
        f.stubs(:service_file).returns Object.new
        f.stubs(:web_daemon).returns Object.new
        f.stubs(:web_file).returns Object.new
        f
      end

      before do
        ::CiInACan::FileSystem.stubs(:create_file)
        ::CiInACan::Cli::Files.stubs(:for).with(data.id, data.root).returns files
      end

      it "should create the proper directories" do
        builder.expects(:create_directories).with ["#{data.root}", "#{data.root}/jobs", "#{data.root}/repos", "#{data.root}/web", "#{data.root}/service", "#{data.root}/results"]
        builder.create
      end

      it "should create the rake file" do
        CiInACan::FileSystem.expects(:create_file).with "#{data.root}/Rakefile", files.rake_file
        builder.create
      end

      it "should create the service file" do
        CiInACan::FileSystem.expects(:create_file).with "#{data.root}/service/service.rb", files.service_file
        builder.create
      end

      it "should create the web daemon file" do
        CiInACan::FileSystem.expects(:create_file).with "#{data.root}/web/stay_alive.rb", files.web_daemon
        builder.create
      end

      it "should create the web file" do
        CiInACan::FileSystem.expects(:create_file).with "#{data.root}/web/config.ru", files.web_file
        builder.create
      end

    end

  end

end
