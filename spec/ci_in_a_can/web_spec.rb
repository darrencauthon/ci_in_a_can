require_relative '../spec_helper'

describe CiInACan::Web do

  let(:params)  { {} }
  let(:session) { {} }

  let(:web) do
    CiInACan::Web.new(params:  params,
                      session: session)
  end

  describe "login page" do

    it "should return the login form html" do

      html       = Object.new
      login_form = Object.new

      login_form.stubs(:to_html).returns html
      CiInACan::ViewModels::LoginForm.stubs(:new).returns login_form

      web.login_page.must_be_same_as html

    end

  end

  describe "submit a passphrase" do

    it "should set the passphrase in session" do

      passphrase = Object.new
      params[:passphrase] = passphrase

      web.submit_a_passphrase

      session[:passphrase].must_be_same_as passphrase

    end

  end

  describe "showing the test result in html" do

    it "should return the html results" do

      params[:id] = Object.new
      test_result = Object.new
      web_content = Object.new
      html        = Object.new

      test_result.stubs(:to_html).returns html

      CiInACan::TestResult.stubs(:find)
                          .with(params[:id])
                          .returns test_result

      CiInACan::WebContent.stubs(:full_page_of)
                          .with(html)
                          .returns web_content

      result = web.show_the_test_result

      result.must_be_same_as web_content

    end

  end

  describe "showing the test result in json" do

    it "should return the json results" do

      params[:id] = Object.new
      test_result = Object.new
      json        = Object.new

      test_result.stubs(:to_json).returns json

      CiInACan::TestResult.stubs(:find)
                          .with(params[:id])
                          .returns test_result

      result = web.show_the_test_result_in_json

      result.must_be_same_as json

    end

  end

  describe "determining if the user is authenticated" do

    it "should return true if the passphrase in session and ENV match" do

      passphrase = Object.new

      ENV.stubs(:[]).with('PASSPHRASE').returns passphrase
      session[:passphrase] = passphrase

      web.logged_in?.must_equal true

    end

    it "should return false if the passphrases do not match" do

      ENV.stubs(:[]).with('PASSPHRASE').returns Object.new
      session[:passphrase] = Object.new

      web.logged_in?.must_equal false

    end

    it "should return false if the passphrases are nil" do

      ENV.stubs(:[]).with('PASSPHRASE').returns nil
      session[:passphrase] = nil

      web.logged_in?.must_equal false

    end

    it "should return false if the passphrases are empty strings" do

      ENV.stubs(:[]).with('PASSPHRASE').returns ""
      session[:passphrase] = ""

      web.logged_in?.must_equal false

    end

  end

  describe "showing the repo edit form" do

    describe "when the id matches an existing repo" do

      it "should return the html for the repo form" do

        id                = Object.new
        params[:captures] = [id]
        repo              = Object.new
        repo_form         = Object.new
        html              = Object.new

        repo_form.stubs(:to_html).returns html

        CiInACan::Repo.stubs(:find).with(id).returns repo
        CiInACan::ViewModels::RepoForm.stubs(:new).with(repo).returns repo_form

        web.show_the_repo_edit_form.must_be_same_as html
          
      end

    end

    describe "when the id has never been used" do

      it "should return the html for a new repo form" do

        id                = Object.new
        params[:captures] = [id]
        repo              = Object.new
        repo_form         = Object.new
        html              = Object.new

        repo_form.stubs(:to_html).returns html

        CiInACan::Repo.stubs(:find).with(id).returns nil
        CiInACan::Repo.stubs(:new).with(id: id).returns repo
        CiInACan::ViewModels::RepoForm.stubs(:new).with(repo).returns repo_form

        web.show_the_repo_edit_form.must_be_same_as html
          
      end

    end

  end

  [:captures, :commands, :expected_id, :expected_commands].to_objects {[
    [['one/two'],   "\na\r\nb\nc\r\nd\n\n", 'one/two',   ['a', 'b', 'c', 'd']],
    [['two/three'], "w\nx\ny\r\nz",         'two/three', ['w', 'x', 'y', 'z']]
  ]}.each do |test|

    describe "updating the repo details" do

      before do
        clear_all_persisted_data
      end

      describe "a repo that has never been saved before" do

        before do
          params[:captures] = test.captures
          params[:commands] = test.commands
        end

        it "should create a repo" do
          web.update_repo_details
          CiInACan::Repo.all.count.must_equal 1
        end

        it "should set the id" do
          web.update_repo_details
          CiInACan::Repo.all.first.id.must_equal test.expected_id
        end

        it "should set the build commands" do
          web.update_repo_details
          CiInACan::Repo.all.first.build_commands.must_equal test.expected_commands
        end

      end

      describe "a repo that been saved before" do

        before do
          CiInACan::Repo.create(id: test.expected_id)
          params[:captures] = test.captures
          params[:commands] = test.commands
        end

        it "should create a repo" do
          web.update_repo_details
          CiInACan::Repo.all.count.must_equal 1
        end

        it "should set the build commands" do
          web.update_repo_details
          CiInACan::Repo.all.first.build_commands.must_equal test.expected_commands
        end

        it "should return the repo" do
          result = web.update_repo_details
          result.is_a? CiInACan::Repo
          result.id.must_equal test.expected_id
        end

      end

    end

  end

  describe "showing a list of the runs" do

    it "should return the html for all of the runs" do

      runs          = Object.new
      array_of_runs = Object.new
      html          = Object.new
      list_of_runs  = Object.new


      CiInACan::Run.stubs(:all).returns runs
      runs.stubs(:to_a).returns array_of_runs
      CiInACan::ViewModels::AListOfRuns.stubs(:new)
                                       .with(array_of_runs)
                                       .returns list_of_runs
      list_of_runs.stubs(:to_html).returns html

      result = web.show_a_list_of_the_runs

      result.must_be_same_as html

    end

  end

  describe "starting a new build" do

    [:url, :repo, :api_key, :jobs_location, :uuid].to_objects {[
      ['account/name/api_key', 'account/name', 'api_key', 'the job', 'the uuid'],
      ['one/two/three',        'one/two',      'three',   'A',       'B']
    ]}.each do |test|

      describe "when the api key is valid" do

        let(:repo) do
          r = Object.new
          r.stubs(:api_key).returns test.api_key
          r
        end

        let(:json) { Object.new }

        before do
          params[:captures] = [test.url]

          params.stubs(:to_json).returns json

          CiInACan::Repo.stubs(:find)
                        .with(test.repo)
                        .returns repo

          CiInACan::Web.stubs(:jobs_location).returns test.jobs_location

          CiInACan::FileSystem.stubs(:create_file)

          uuid = Object.new
          uuid.stubs(:generate).returns test.uuid
          UUID.stubs(:new).returns uuid
        end

        it "should not fail when we call it" do
          web.start_a_new_build
        end

        it "should write a file" do
          CiInACan::FileSystem.expects(:create_file)
                              .with("#{test.jobs_location}/#{test.uuid}.json", json)
          web.start_a_new_build
        end

        it "should return the json back" do
          web.start_a_new_build.must_be_same_as json
        end

      end

    end

    [:url, :repo, :api_key, :jobs_location, :uuid].to_objects {[
      ['account/name/api_key', 'account/name', 'api_key', 'the job', 'the uuid'],
    ]}.each do |test|

      describe "when the repo does not exist" do

        let(:repo) do
          r = Object.new
          r.stubs(:api_key).returns test.api_key
          r
        end

        before do
          params[:captures] = [test.url]

          CiInACan::Repo.stubs(:find)
                        .with(test.repo)
                        .returns nil

          CiInACan::FileSystem.stubs(:create_file)

          uuid = Object.new
          uuid.stubs(:generate).returns test.uuid
          UUID.stubs(:new).returns uuid
        end

        it "should throw an error" do
          error_hit = false
          begin
            web.start_a_new_build
          rescue
            error_hit = true
          end

          error_hit.must_equal true
        end

        it "should not write any files" do
          called = false
          # having some issue with never?
          CiInACan::FileSystem.stubs(:create_file).with { |a, b| [a, b].inspect; called = true; true }
          -> { web.start_a_new_build }.call_safely
          called.must_equal false
        end

      end

    end

    [:url, :repo, :api_key, :jobs_location, :uuid, :the_other_api_key].to_objects {[
      ['account/name/api_key', 'account/name', 'api_key', 'the job', 'the uuid', 'sdf'],
      ['account/name/api_key', 'account/name', 'api_key', 'the job', 'the uuid', 'abc'],
    ]}.each do |test|

      describe "when the repo api key does not match the request" do

        let(:repo) do
          r = Object.new
          r.stubs(:api_key).returns test.the_other_api_key
          r
        end

        before do
          params[:captures] = [test.url]

          CiInACan::Repo.stubs(:find)
                        .with(test.repo)
                        .returns repo

          CiInACan::FileSystem.stubs(:create_file)

          uuid = Object.new
          uuid.stubs(:generate).returns test.uuid
          UUID.stubs(:new).returns uuid
        end

        it "should throw an error" do
          error_hit = false
          begin
            web.start_a_new_build
          rescue
            error_hit = true
          end

          error_hit.must_equal true
        end

        it "should not write any files" do
          called = false
          # having some issue with never?
          CiInACan::FileSystem.stubs(:create_file).with { |a, b| [a, b].inspect; called = true; true }
          -> { web.start_a_new_build }.call_safely
          called.must_equal false
        end

      end

    end

  end

end
