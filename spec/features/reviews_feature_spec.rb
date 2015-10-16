require 'rails_helper'

feature 'reviewing' do

  let!(:restaurant){ create :restaurant }
  let(:user){ build :user }
  let(:user2){ build :user2 }

  before do
    sign_up(user)
  end

  scenario 'allows users to leave a review using a form' do
    leave_review('so so',5)
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'if restaurant is deleted reviews are also deleted' do
    leave_review('so, so', 5)
    click_link "Delete #{restaurant.name}"
    expect(page).not_to have_content "so so"
    expect(current_path).to eq '/restaurants'
  end

  scenario 'users cannot review the same restaurant twice' do
    leave_review('so, so', 4)
    leave_review('still so, so', 4)
    expect(page).to have_content 'You have already reviewed this restaurant'
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So so', 3)
    click_link('Sign out')
    sign_up(user2)
    leave_review('Great', 5)
    expect(page).to have_content('Average Rating: ★★★★☆')
  end

  context "deleting reviews" do
    scenario "users can delete their reviews" do
      leave_review('Great', 5)
      click_link('Remove')
      expect(page).not_to have_content('Great')
    end

    scenario "can't delete other users reviews" do
      leave_review('Great', 5)
      click_link('Sign out')
      sign_up(user2)
      click_link('Remove')
      expect(page).to have_content "You can't remove other people's reviews"
      expect(page).to have_content('Great')
    end
  end
end
