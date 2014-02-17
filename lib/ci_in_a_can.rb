require 'json'
require 'uuid'
require 'subtle'

require_relative "ci_in_a_can/version"
require_relative "ci_in_a_can/view_models/view_model"
Dir[File.dirname(__FILE__) + '/ci_in_a_can/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/ci_in_a_can/view_models/*.rb'].each { |file| require file }

module CiInACan

  class << self
    attr_accessor :results_location
    attr_accessor :site_url
  end

end
