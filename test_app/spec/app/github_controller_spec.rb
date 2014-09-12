require_relative '../minitest_helper'

describe GithubController do

  let(:controller) { GithubController.new }

  it "should be an application controller" do
    controller.is_a?(ApplicationController).must_equal true
  end

end
