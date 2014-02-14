require_relative '../spec_helper'

describe CiInACan::LastRunList do

  before do
    clear_all_persisted_data
  end

  describe "add" do

    let(:build)       { CiInACan::Build.new }
    let(:test_result) { CiInACan::TestResult.new }

    it "should store information that we can pull out later" do
      CiInACan::LastRunList.add build, test_result

      results = CiInACan::LastRunList.all
      results.count.must_equal 1

      expected = { created_at: test_result.created_at }
      results.first.contrast_with! expected
    end

  end

end
