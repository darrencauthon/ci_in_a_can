require_relative '../lib/ci_in_a_can'
require 'minitest/autorun'
require 'minitest/spec'
require 'subtle'
require 'contrast'
require 'timecop'
require 'mocha/setup'

def random_string
  SecureRandom.uuid
end
