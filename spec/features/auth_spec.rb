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
      click_on "Sign Up"
      expect(page).to have_content("#{user.username}")
    end

  end

end

# feature "logging in" do
#
#   it "shows username on the homepage after login"
#
# end
#
# feature "logging out" do
#
#   it "begins with logged out state"
#
#   it "doesn't show username on the homepage after logout"
# 
# end
