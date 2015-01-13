require 'spec_helper'
require 'rails_helper'

feature 'creating a goal' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  before(:each) do
    visit new_session_url
    fill_in 'Username', with: user1.username
    fill_in 'Password', with: user1.password
    click_on "Sign In"
  end

  it 'user can create a valid goal' do
    visit new_goal_url
    goal = build(:goal, is_private: true)
    fill_in 'Title', with: goal.title
    fill_in 'Body', with: goal.body
    choose('Private')
    click_on "Create Goal"
    expect(page).to have_content("#{goal.title}")
    expect(page).to have_content("#{goal.body}")
    expect(user1.goals.pluck(:title)).to include(goal.title)
  end

  let!(:private_goal) { build(:goal, title: "A private goal", is_private: true) }
  let!(:public_goal) { build(:goal, title: "A public goal",  is_private: false) }

  before(:each) do
    visit new_goal_url
    fill_in 'Title', with: private_goal.title
    fill_in 'Body', with: private_goal.body
    choose('Private')
    click_on "Create Goal"

    visit new_goal_url
    fill_in 'Title', with: public_goal.title
    fill_in 'Body', with: public_goal.body
    choose('Public')
    click_on "Create Goal"
  end

  it 'can see own goals' do
    visit user_url(user1)
    expect(page).to have_content("#{private_goal.title}")
    expect(page).to have_content("#{private_goal.body}")
    expect(page).to have_content("#{public_goal.title}")
    expect(page).to have_content("#{public_goal.body}")
  end

  it 'can edit and complete a goal' do
    visit edit_goal_url(user1.goals.first)
    fill_in 'Title', with: "edited title"
    choose('Completed')
    click_on "Update"
    expect(page).to have_content("edited title")
    expect(page).to have_content("COMPLETED")
  end

  it 'can delete a goal' do
    title = user1.goals.first.title
    visit goal_url(user1.goals.first)
    click_on "Delete"
    expect(page).not_to have_content("#{title}")
  end
end

feature 'viewing goals' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:private_goal) { build(:goal, title: "A private goal", is_private: true) }
  let!(:public_goal) { build(:goal, title: "A public goal",  is_private: false) }

  before(:each) do
    visit new_session_url
    fill_in 'Username', with: user1.username
    fill_in 'Password', with: user1.password
    click_on "Sign In"

    visit new_goal_url
    fill_in 'Title', with: private_goal.title
    fill_in 'Body', with: private_goal.body
    choose('Private')
    click_on "Create Goal"

    visit new_goal_url
    fill_in 'Title', with: public_goal.title
    fill_in 'Body', with: public_goal.body
    choose('Public')
    click_on "Create Goal"

    click_on "Sign Out"
    fill_in 'Username', with: user2.username
    fill_in 'Password', with: user2.password
    click_on "Sign In"
  end

  it 'can only see public goals' do
    visit goals_url
    expect(page).to have_content(public_goal.title)
    expect(page).not_to have_content(private_goal.title)
  end

end
