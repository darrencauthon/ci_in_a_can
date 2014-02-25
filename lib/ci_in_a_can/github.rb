require 'octokit'

module CiInACan

  module Github

    class << self
      attr_accessor :access_token
    end

    def self.client
      return nil if access_token.to_s == ''
      Octokit::Client.new(access_token: access_token)
    end

    def self.report_pending_status_for build
      return nil unless client
      client.create_status build.repo, build.sha, 'pending'
    end

    def self.report_complete_status_for build, test_result
      return nil unless client
      client.create_status(build.repo, build.sha, 
                           complete_status_from(test_result), 
                           { 
                             target_url:  target_url_for(test_result),
                             description: test_result.output_summary
                           } )
    end

    private

    def self.target_url_for test_result
      "#{CiInACan.site_url}/test_result/#{test_result.id}"
    end

    def self.complete_status_from test_result
      (test_result.passed ? 'success' : 'failure')
    end

  end

end
