require 'octokit'

module CiInACan

  module Github

    class << self
      
      attr_accessor :access_token

      def client
        return nil unless access_token
        Octokit::Client.new access_token: access_token
      end

    end

  end

end
