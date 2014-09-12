class GithubController < ApplicationController
  def push
    CiInACan::Build.start params
  end
end
