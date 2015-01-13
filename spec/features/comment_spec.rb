require 'spec_helper'
require 'rails_helper'

describe Comment do
  describe "associations" do
    it { should belong_to(:author) }
    it { should belong_to(:comment_subject) }
  end

  feature 'creating a comment' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:public_goal) { build(:goal, title: "A public goal",  is_private: false) }

    before(:all) do
      visit new_session_url
      fill_in 'Username', with: user1.username
      fill_in 'Password', with: user1.password
      click_on "Sign In"
      visit new_goal_url
      fill_in 'Title', with: public_goal.title
      fill_in 'Body', with: public_goal.body
      choose('Public')
      click_on "Create Goal"
      click_on "Sign Out"

      visit new_session_url
      fill_in 'Username', with: user2.username
      fill_in 'Password', with: user2.password
      click_on "Sign In"
    end

    it "should be able to comment on a public goal" do
      click_on "#{public_goal.title}"
      expect(page).to have_content("Add Comment")
      fill_in 'Body', with: "This is an awesome goal!"
      click_on "Submit Comment"
      expect(page).to have_content("This is an awesome goal!")
    end

    it "should be able to comment on a user" do
      visit user_url(user1)
      expect(page).to have_content("Add Comment")
      fill_in 'Body', with: "This is an awesome user!"
      click_on "Submit Comment"
      expect(page).to have_content("This is an awesome user!")
    end

  end



end
