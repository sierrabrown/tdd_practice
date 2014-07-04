require 'spec_helper'

feature "the signup process" do 
  
  it "has a new user page" do
    visit('/users/new')
    expect(page).to have_content('Sign Up!')
    expect(page).to have_content('E-Mail')
    expect(page).to have_content('Password')
  end
  
  feature "signing up a user" do
    it "shows username on the homepage after signup" do
      sign_up_as_test_user
      expect(page).to have_content("Signed in as test_user")
      expect(page).to have_content("Home Page")
    end
  end
end

feature "logging in" do 

  it "shows username on the homepage after login" do
    sign_up_as_test_user
    expect((page.current_url) == goals_url).to eq true
    expect(page).to have_content("Home Page")
  end
  
end

feature "logging out" do 

  it "begins with logged out state" do
    visit(goals_url)
    expect(page).to have_content("Sign In!")
  end

  it "doesn't show username on the homepage after logout" do
    sign_up_as_test_user
    click_button("Sign out")
    expect(page).to_not have_content("test_user")
  end
end