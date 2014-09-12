require_relative '../../spec_helper'

describe CiInACan::CloneTheGithubRepoToALocalDirectory do

  let(:worker) { CiInACan::CloneTheGithubRepoToALocalDirectory.new }

  it "should be a seam worker" do
    worker.is_a?(Seam::Worker).must_equal true
  end

  describe "process the request" do

    it "should clone the repository" do

      data = { clone_url: 'x' }
      effort = Struct.new(:data).new data
      worker.stubs(:effort).returns effort

      CiInACan::BashRunner.expects(:execute).with 'git clone x'

      worker.process
        
    end

  end

end
