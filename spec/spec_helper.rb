require_relative '../lib/ci_in_a_can'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'subtle'
require 'contrast'
require 'timecop'
require 'mocha/setup'

def CiInACan.results_location
  File.expand_path(File.dirname(__FILE__) + '/temp')
end
