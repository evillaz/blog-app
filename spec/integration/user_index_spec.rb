require 'rails_helper'
RSpec.describe 'Users Index Page', type: :feature do
  let!(:users) do
    User.create([{ name: 'Milt', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.' },
                 { name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo.', bio: 'Teacher from England.' },
                 { name: 'Chris', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Developer from congo' }])
  end
  let!(:posts) do
    Post.create!([{ author: users[0], title: 'First Post', text: 'My first post' },
                  { author: users[1], title: 'Second Post', text: 'My Second post' },
                  { author: users[2], title: 'Third Post', text: 'My Third post' }])
  end
  before do
    visit users_path
  end
  context 'when viewing the page' do
    it 'shows all users.' do
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'shows the profile picture for each user.' do
      users.each do |user|
        expect(page).to have_css("img[src*='#{user.photo}']")
      end
    end
    it 'shows how many posts each user has written.' do
      users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end
  end
  context 'when clicking on a user' do
    it 'visits users show page.' do
      click_on users[1].name
      expect(page).to have_current_path(user_path(users[1]))
    end
  end
end
