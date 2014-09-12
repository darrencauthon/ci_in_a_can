require_relative '../../spec_helper'

describe CiInACan::CloneTheGithubRepoToALocalDirectory do

  let(:worker) { CiInACan::CloneTheGithubRepoToALocalDirectory.new }

  it "should be a seam worker" do
    worker.is_a?(Seam::Worker).must_equal true
  end

  describe "process the request" do

    [
      ['x', 'git clone x'],
      ['y', 'git clone y'],
      ['z', 'git clone z'],
    ].map { |x| Struct.new(:clone_url, :bash_statement).new *x }.each do |example|

      describe "multiple examples" do

        it "should clone the repository" do

          data = { 'clone_url' => example.clone_url }
          effort = Struct.new(:data).new data
          worker.stubs(:effort).returns effort

          CiInACan::BashRunner.expects(:execute).with example.bash_statement

          worker.process
            
        end

      end

    end

  end

end
