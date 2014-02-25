require_relative '../../spec_helper'

describe CiInACan::Cli::StructureBuilder do

  it "should have a root id and an id" do
    id   = Object.new
    root = Object.new
    builder = CiInACan::Cli::StructureBuilder.new(id: id, root: root)
    builder.id.must_be_same_as id
    builder.root.must_be_same_as root
  end

end
