ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  include AuthenticatedTestHelper
  
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_not_valid(model,msg="record was valid but shouldn't be")
    assert_block(msg) { !model.valid? }
  end
  
  def assert_cached_fragment(fragment_name, message = "fragment doesn't exist but it should")
    assert_block(message){ Rails.cache.exist?("views/#{fragment_name}") }
  end
  
  def assert_not_cached_fragment(fragment_name, message = "fragment exists but it shouldn't")
    assert_block(message){ !Rails.cache.exist?("views/#{fragment_name}") }
  end
  
  def assert_cached_page(page_name, message = "file doesn't exist but it should")
    assert_block(message){ File.exist?("#{RAILS_ROOT}/public/#{page_name}") }
  end
  
  def assert_not_cached_page(page_name, message = "file exists but it shouldn't")
    assert_block(message){ !File.exist?("#{RAILS_ROOT}/public/#{page_name}") }
  end
  
  def login_as_admin
    session[:admin] = admins(:first)
  end
end
