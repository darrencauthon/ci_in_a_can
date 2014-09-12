class GithubController < ApplicationController
  def push
    CiInACan::Build.start params[:payload]
  end
end
