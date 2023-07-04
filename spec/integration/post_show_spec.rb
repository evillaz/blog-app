require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  let!(:user) do
    User.create({ name: 'Eduardo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.' })
  end
  let!(:post) do
    Post.create!({ author: user, title: 'Third Post', text: 'My first post' })
  end
  let!(:comments) do
    Comment.create!([ { author: user, post: post, text: 'First comment' },
                      { author: user, post: post, text: 'Second comment' },
                      { author: user, post: post, text: 'Third comment' },
                      { author: user, post: post, text: 'Fourth comment' },
                      { author: user, post: post, text: 'Fifth comment' },
                      { author: user, post: post, text: 'Sixth comment' }])
  end
  before do 
    visit user_post_path(user, post)
  end
  context "when viewing the page" do
    it 'i can see a posts title' do
      expect(page).to have_content(post.title)
    end
    it 'i can see who wrote the post.' do
      expect(page).to have_content(user.name)
    end
    it 'i can see how many comments it has.' do
      expect(page).to have_content(post.comments_counter)
    end
    it 'i can see how many likes it has.' do
      expect(page).to have_content(post.likes_counter)
    end
    it 'i can see the post body' do
      expect(page).to have_content(post.text)
    end
    it 'i can see the username of each commentor.' do
      comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end
    it 'i can see the comment each commentor left.' do
      comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end