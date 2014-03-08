require_relative '../spec_helper'

describe CiInACan::Web do

  describe "login page" do

    it "should return the login form html" do

      html       = Object.new
      login_form = Object.new

      login_form.stubs(:to_html).returns html
      CiInACan::ViewModels::LoginForm.stubs(:new).returns login_form

      CiInACan::Web.new.login_page.must_be_same_as html

    end

  end

  describe "submit a passphrase" do

    it "should set the passphrase in session" do

      passphrase = Object.new
      params     = { passphrase: passphrase }
      session    = {}

      web = CiInACan::Web.new(params: params, session: session)

      web.submit_a_passphrase

      session[:passphrase].must_be_same_as passphrase
        
    end

  end

  describe "showing the test result in json" do

    it "should return the json results" do

      params      = { id: Object.new}
      test_result = Object.new
      json        = Object.new

      test_result.stubs(:to_json).returns json

      CiInACan::TestResult.stubs(:find)
                          .with(params[:id])
                          .returns test_result

      result = CiInACan::Web.new(params: params).show_the_test_result_in_json

      result.must_be_same_as json
        
    end

  end

end
