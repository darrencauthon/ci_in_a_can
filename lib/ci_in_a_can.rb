require 'json'
require 'uuid'
require 'seam'

require_relative "ci_in_a_can/version"
Dir[File.dirname(__FILE__) + '/ci_in_a_can/*.rb'].each { |f| require f }

module CiInACan
end
