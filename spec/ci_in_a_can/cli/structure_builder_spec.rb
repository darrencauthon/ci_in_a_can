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

      it "should create the proper directories" do
        builder.expects(:create_directories).with ["#{data.root}", "#{data.root}/jobs", "#{data.root}/repos", "#{data.root}/web", "#{data.root}/service", "#{data.root}/results"]
        builder.create
      end

    end

  end

end
