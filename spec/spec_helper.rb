ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end


def sign_up(username)
  visit "/users/new"
  fill_in "E-Mail", with: username
  fill_in "Password", with: 'abcdef'
  click_button 'Sign Up'
end

def sign_up_as_test_user
  sign_up("test_user@testdrivendevelopment.com")
end

def sign_in(username)
  visit "/session/new"
  fill_in "E-Mail", with: username
  fill_in "Password", with: 'abcdef'
  click_button 'Sign In'
end

def sign_in_as_test_user
  sign_up_as_test_user
  click_button 'Sign out'
  sign_in("test_user")
end

def make_goal(goal, privacy, status)
  visit goals_url
  click_link 'Create New Goal'
  fill_in 'Title', with: goal
  choose privacy
  select status, :from => 'Status'
  click_button 'Create New Goal'
end

def make_test_goal
  make_goal("test_goal",'Public','Incomplete')
end

def update_test_goal
  make_test_goal
  click_link "Edit Goal"
  fill_in 'Title', with: 'updated_goal'
  choose 'Private'
  select 'Complete', :from => 'Status'
  click_button 'Edit Goal'
end
  

