require_relative '../spec_helper'

describe CiInACan::Build do

  it "should default commands to the basic ruby conventions" do
    result = CiInACan::Build.new.commands
    result.count.must_equal 2
    result[0].must_equal 'bundle install'
    result[1].must_equal 'bundle exec rake'
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
