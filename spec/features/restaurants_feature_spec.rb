require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do

    let!(:restaurant){ create :restaurant }

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content restaurant.name
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do

    it 'user must be signed in to add restaurants' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in'
    end

    context 'after user signs in' do

      let(:user){ build :user }

      before do
        sign_up(user)
      end

      scenario 'prompts user to fill out a form, then displays the new restaurant' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
      end

      context 'an invalid restaurant' do
        it 'does not let you submit a name that is too short' do
          visit '/restaurants'
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end
    end

  end

  context 'viewing restaurants' do

    let!(:restaurant){ create :restaurant }

    scenario 'lets a user view a restaurant' do
     visit '/restaurants'
     click_link restaurant.name
     expect(page).to have_content restaurant.name
     expect(current_path).to eq "/restaurants/#{restaurant.id}"
    end
  end

  context 'editing restaurants' do

    let!(:restaurant){ create :restaurant }
    let(:user){ build :user }

    before do
      sign_up(user)
    end

    scenario 'let a user edit a restaurant' do
     visit '/restaurants'
     click_link "Edit #{restaurant.name}"
     fill_in 'Name', with: 'New Name'
     click_button 'Update Restaurant'
     expect(page).to have_content 'New Name'
     expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    let!(:restaurant){ create :restaurant }
    let(:user){ build :user }

    before do
      sign_up(user)
    end

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link "Delete #{restaurant.name}"
      expect(page).not_to have_content restaurant.name
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
