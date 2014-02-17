require_relative '../spec_helper'

describe CiInACan::Run do

  before do
    clear_all_persisted_data
  end

  describe "add" do

    let(:build)       { CiInACan::Build.new }
    let(:test_result) { CiInACan::TestResult.new }

    it "should store information that we can pull out later" do
      CiInACan::Run.add build, test_result

      results = CiInACan::Run.all
      results.count.must_equal 1

      results.first.created_at.must_equal test_result.created_at 
    end

    it "should track the test_result_id" do

      test_result.id = UUID.new.generate

      CiInACan::Run.add build, test_result

      results = CiInACan::Run.all

      results.first.test_result_id.must_equal test_result.id
        
    end

    it "should track the build id" do
      build.id = UUID.new.generate
      CiInACan::Run.add build, test_result
      CiInACan::Run.all.first.build_id.must_equal build.id
    end

    it "should track the build id" do
      build.id = UUID.new.generate
      CiInACan::Run.add build, test_result
      CiInACan::Run.all.first.build_id.must_equal build.id
    end

    it "should track the build sha" do
      build.sha = UUID.new.generate
      CiInACan::Run.add build, test_result
      CiInACan::Run.all.first.sha.must_equal build.sha
    end

    it "should track the build repo" do
      build.repo = UUID.new.generate
      CiInACan::Run.add build, test_result
      CiInACan::Run.all.first.repo.must_equal build.repo
    end

    it "should track the branch" do
      build.branch = UUID.new.generate
      CiInACan::Run.add build, test_result
      CiInACan::Run.all.first.branch.must_equal build.branch
    end

    [true, false].each do |passed|
      describe "the test_result outcome" do

        let(:build)       { CiInACan::Build.new }
        let(:test_result) { CiInACan::TestResult.new }

        it "should track the test_result passed outcome" do
          test_result.passed = passed

          CiInACan::Run.add build, test_result

          results = CiInACan::Run.all

          results.first.passed.must_equal passed
        end

      end
    end

  end

  describe "all" do

    describe "sorting" do

      let(:build) { CiInACan::Build.new }
      it "should sort by created_at in DESC order" do

        test_results = [CiInACan::TestResult.new(id: 'c', created_at: Time.parse('1/3/2014')),
                        CiInACan::TestResult.new(id: 'a', created_at: Time.parse('1/1/2014')),
                        CiInACan::TestResult.new(id: 'b', created_at: Time.parse('1/2/2014'))]

        test_results.each { |t| CiInACan::Run.add build, t }

        results = CiInACan::Run.all
        results[0].test_result_id.must_equal 'c'
        results[1].test_result_id.must_equal 'b'
        results[2].test_result_id.must_equal 'a'
      end

    end

  end

  describe "to html" do
    it "should show the results of run_view_model" do
      html       = Object.new
      view_model = Object.new

      run = CiInACan::Run.new

      view_model.stubs(:to_html).returns html

      CiInACan::ViewModels::RunViewModel
        .stubs(:new)
        .with(run)
        .returns view_model

      run.to_html.must_be_same_as html
    end
  end

end
