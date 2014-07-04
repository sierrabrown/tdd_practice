require 'spec_helper'

feature 'create a new goal' do
  before :each do
    sign_up_as_test_user
  end
  
  it 'your goals index page has a link to make a new goal' do
    expect(page).to have_content('Create New Goal')
  end
  
  feature 'the goal creation process' do
    
    it 'should display the goal show page with edit link after creation' do
      make_test_goal
      expect(page).to have_content('test_goal')
      expect(page).to have_content('Edit Goal')
    end
    
  end
  
end

feature 'viewing your goals' do
  before :each do
    sign_up_as_test_user
  end
  
  it 'displays the goal title, status, and privacy level and back button' do
    make_test_goal
    expect(page).to have_content('Privacy Level: public')
    expect(page).to have_content('Status: Incomplete')
    expect(page).to have_content('Goal: test_goal')
    expect(page).to have_content('Back to your goals')
  end
  
  feature 'viewing all your goals on the index page' do
    
    it 'displays a list of all your goals w/ links to their show pages' do
      make_test_goal
      click_link('Back to your goals')
      make_goal('another_goal', 'Private', 'Incomplete')
      click_link('Back to your goals')
      expect(page).to have_content('test_goal')
      expect(page).to have_content('another_goal')
      click_link('another_goal')
      expect(page).to have_content('Incomplete')
    end
    
  end
end

feature 'updating or deleting goals' do
  before :each do
    sign_up_as_test_user
  end
  
  it 'updates goal attributes' do
    update_test_goal
    expect(page).to have_content('Privacy Level: private')
    expect(page).to have_content('Status: Complete')
    expect(page).to have_content('Goal: updated_goal')
    expect(page).to have_content('Back to your goals')
  end
    
  it 'removes goal and redirects to goals page after deletion' do
    make_test_goal
    click_button('Delete Goal')
    expect(page).to_not have_content('test_goal')
    expect(page).to have_content('test_user')
  end
  
end


feature 'sorting goals into completed and uncompleted' do
  before :each do
    sign_up_as_test_user
    visit(goals_url)
    make_goal('Playing Super Smash Bros', 'Public', 'Complete')
    make_goal('Becoming TDD specialists', 'Private', 'Complete')
    make_goal('Program', 'Private', 'Incomplete')
    make_goal('Survive until 6', 'Private', 'Incomplete')
    visit(goals_url)
  end
  
  feature 'the completed goals page' do
    before :each do
      click_link("Completed Goals")
    end
    
    it 'presents completed goals' do
      expect(page).to have_content("Playing Super Smash Bros")
      expect(page).to have_content("Becoming TDD specialists")
    end
  
    it 'does not have uncompleted goals' do
      expect(page).to_not have_content("Program")
      expect(page).to_not have_content("Survive until 6")
    end
  end
  
  feature 'the uncompleted goals page' do
    before :each do
      click_link("Incomplete Goals")
    end
    
    it 'presents uncompleted goals' do
      expect(page).to have_content("Program")
      expect(page).to have_content("Survive until 6")
    end
  
    it 'does not have completed goals' do
      expect(page).to_not have_content("Playing Super Smash Bros")
      expect(page).to_not have_content("Becoming TDD specialists")
    end
  end
end