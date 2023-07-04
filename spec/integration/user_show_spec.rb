require 'rails_helper'

RSpec.describe 'Users Show Page', type: :feature do
  let!(:user) do
    User.create({ name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.' })
  end
  let!(:posts) do
    Post.create!([{ author: user, title: 'First Post', text: 'My first post' },
                  { author: user, title: 'Second Post', text: 'My Second post' },
                  { author: user, title: 'Third Post', text: 'My Third post' },
                  { author: user, title: 'Fourth Post', text: 'My Fourth post' }])
  end
  before do 
    visit user_path(user)
  end
  context "when viewing the page" do
    it 'shows the profile picture for user.' do
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
    it 'shows the users username.' do
      expect(page).to have_content(user.name)
    end
    it 'shows how many posts each user has written.' do
      expect(page).to have_content(user.posts_counter)
    end
    it 'shows the users bio.' do
      expect(page).to have_content(user.bio)
    end
    it 'displays the users 3 recent posts.' do
      user.recent_posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
      end
    end
    it 'displays a button to see all posts' do
      expect(page).to have_button("See all posts")
    end
  end
  context "when clicking in the Users Show Page" do
    it 'redirects me to that posts show page, When I click a users post' do
      click_on posts[3].title
      expect(page).to have_current_path(user_post_path(user, posts[3]))
    end
    it 'redirects me to the users posts index page, when I click to see all posts' do
      click_button("See all posts")
      expect(page).to have_current_path(user_posts_path(user))
    end
  end
end