require 'subtle'

require_relative "ci_in_a_can/version"
Dir[File.dirname(__FILE__) + '/ci_in_a_can/*.rb'].each { |file| require file }

module CiInACan

  class << self
    attr_accessor :results_location
  end

end
