require_relative 'lib/ci_in_a_can'

CiInACan::App.jobs_location = "jobs"

use CiInACan::App
run Sinatra::Application
