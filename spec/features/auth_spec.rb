require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      visit new_user_url
      user = build(:user)
      expect(user).to be_valid
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_on "Sign Up!"
      expect(page).to have_content("#{user.username}")
    end

  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    visit new_session_url
    expect(page).to have_content("Sign In")
    # persist dummy user to DB (use FactoryGirl##create)
    # log_in user
    user = create(:user)
    expect(user).to be_valid
    # and check for content
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on "Sign In"
    expect(page).to have_content("#{user.username}")
  end
end

feature "logging out" do
  let!(:user) { create(:user) }
  before(:each) do
    visit new_session_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on "Sign In"
  end

  it "begins with logged out state" do
    click_on "Sign Out"
    expect(page).to have_content("Log In")

  end

  it "doesn't show username on the homepage after logout" do
    click_on "Sign Out"
    expect(page).not_to have_content("#{user.username}")
  end
end
