class GithubController < ApplicationController
  def push
    data = params
    #data = { 
      #'compare' => "https://github.com/darrencauthon/ci_in_a_can/commit/b1c5f9c9588f",
      #'ref'     => "refs/heads/blah",
      #'head_commit' => { "id" => "b1c5f9c9588fea9cb592c88905a2af349e43a4b6" }
    #}.to_json
    #data = { 'payload' => data }.to_json
    parser = CiInACan::GithubPayloadParser.new
    CiInACan::Build.start parser.parse(data)
    render json: {}
  end
end
