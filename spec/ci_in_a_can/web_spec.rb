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

end
