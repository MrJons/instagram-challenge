require 'rails_helper'

feature 'photos' do

  context 'no photos should have been added' do

    scenario 'user should recieve a prompt to add a photo' do
      visit '/photos'
      expect(page).to have_content('Nothing seems to have been added yet.')
      expect(page).to have_link('Add photo')
    end
  end

  context 'Added photos appear on main page' do

    before do
      Photo.create(description: 'My makers pic')
    end

    scenario 'display photo / description' do #photo element to be added.
      visit '/photos'
      expect(page).to have_content('My makers pic')
      expect(page).not_to have_content('Nothing seems to have been added yet.')
    end
  end

  context 'Adding photos' do

    scenario 'prompts user to fill out a form, then links back to main page' do
      visit '/photos'
      click_link 'Add photo'
      attach_file('Image', '/Users/Jon/Desktop/jonathan_shad.jpg')
      fill_in 'Description', with: 'My makers pic'
      click_button 'Add photo'
      expect(page).to have_content('jonathan_shad.jpg')
      expect(page).to have_content('My makers pic')
      expect(current_path).to eq '/photos'
    end
  end
end