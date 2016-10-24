ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  Minitest::Reporters.use!

  # Add more helper methods to be used by all tests here...

  def setup
    # setup runs before each of your test cases (can't ruin it in one test case)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({provider: 'github', uid: '12342', info: {email: 'a@b.com', name: "Ada"}})
  end
end
