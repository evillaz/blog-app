require 'rails_helper'

RSpec.describe 'Posts Index Page', type: :feature do
  let!(:user) do
    User.create({ name: 'Gia', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.' })
  end
  let!(:posts) do
    Post.create!([{ author: user, title: 'First Post', text: 'My first post' },
                  { author: user, title: 'Second Post', text: 'My Second post' },
                  { author: user, title: 'Third Post', text: 'My Third post' },
                  { author: user, title: 'Fourth Post', text: 'My Fourth post' }])
  end
  let!(:comments) do
    Comment.create!([ { author: user, post: posts[0], text: 'First comment' },
                      { author: user, post: posts[0], text: 'Second comment' },
                      { author: user, post: posts[0], text: 'Third comment' },
                      { author: user, post: posts[0], text: 'Fourth comment' },
                      { author: user, post: posts[0], text: 'Fifth comment' },
                      { author: user, post: posts[0], text: 'Sixth comment' },
                      { author: user, post: posts[1], text: 'First comment' },
                      { author: user, post: posts[2], text: 'First comment' },
                      { author: user, post: posts[3], text: 'First comment' }])
  end
  before do 
    visit user_posts_path(user)
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
    it 'i can see a posts title' do
      expect(page).to have_content(posts[0].title)
    end
    it 'i can see some of the posts body' do
      expect(page).to have_content(posts[0].text)
    end
    it 'i can see the recents comments on a post.' do
      posts[0].recent_comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
    it 'i can see how many comments a post has.' do
      expect(page).to have_content(posts[0].comments_counter)
    end
    it 'i can see how many likes a post has.' do
      expect(page).to have_content(posts[0].likes_counter)
    end
    it 'i can see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_css('.pagination')
    end
  end
  context "when clicking in the Post index Page" do
    it 'redirects me to that posts show page, When I click a users post' do
      click_on posts[0].title
      expect(page).to have_current_path(user_post_path(user, posts[0]))
    end
  end
end