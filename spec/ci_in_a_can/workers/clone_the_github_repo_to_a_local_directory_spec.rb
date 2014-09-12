require_relative '../../spec_helper'

describe CiInACan::CloneTheGithubRepoToALocalDirectory do

  let(:worker) { CiInACan::CloneTheGithubRepoToALocalDirectory.new }

  it "should be a seam worker" do
    worker.is_a?(Seam::Worker).must_equal true
  end

end
