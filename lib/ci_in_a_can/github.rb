require 'octokit'

module CiInACan

  module Github

    class << self
      
      attr_accessor :access_token

      def client
        return nil unless access_token
        Octokit::Client.new access_token: access_token
      end

      def report_pending_status_for build
        return nil unless client
        client.create_status build.repo, build.sha, 'pending'
      end

      def report_complete_status_for build, test_result
        return nil unless client
        client.create_status build.repo, build.sha, (test_result.passed ? 'success' : 'failure')
      end

    end

  end

end
