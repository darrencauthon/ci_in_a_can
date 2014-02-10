require 'subtle'

require_relative "ci_in_a_can/version"
Dir[File.dirname(__FILE__) + '/ci_in_a_can/*.rb'].each { |file| require file }

module CiInACan

  def self.results_location
    File.expand_path(File.dirname(__FILE__) + '/../../results')
  end

end
