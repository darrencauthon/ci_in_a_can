class GithubController < ApplicationController
  def push
    parser = CiInACan::GithubPayloadParser.new
    CiInACan::Build.start parser.parse(params)
  end
end
