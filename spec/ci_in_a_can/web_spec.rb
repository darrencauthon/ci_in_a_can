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

end
