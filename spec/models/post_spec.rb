require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Eduardo1') }
  let!(:post) { user.posts.create(title: 'Testing') }
  let!(:post2) { user.posts.create(title: 'Testing2') }
  let!(:comments) do
    Comment.create!([{ author: user, post:, text: 'First comment' },
                     { author: user, post:, text: 'Second comment' },
                     { author: user, post:, text: 'Third comment' },
                     { author: user, post:, text: 'Fourth comment' },
                     { author: user, post:, text: 'Fifth comment' },
                     { author: user, post:, text: 'Sixth comment' }])
  end

  it 'title should be present' do
    post.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not exceed 250 characters' do
    expect(post).to be_valid
  end

  it 'comments counter should be integer value' do
    post.comments_counter = 'not valid'
    expect(post).to_not be_valid
  end

  it 'comments counter should be a number greater or equal to zero' do
    post.comments_counter = -1
    expect(post).to_not be_valid
  end

  it 'likes counter should be integer value' do
    post.likes_counter = 'not valid'
    expect(post).to_not be_valid
  end

  it 'likes counter should be a number greater or equal to zero' do
    post.likes_counter = -1
    expect(post).to_not be_valid
  end

  it 'returns the last five comments on the post' do
    expect(post.recent_comments.length).to eq(5)
  end

  describe 'update user posts counter method' do
    it 'should update users posts counter' do
      user.reload
      expect(user.posts_counter).to eq(2)
    end

    it 'should update user posts counter on post destroy' do
      user.reload
      user.posts.last.destroy
      user.reload
      expect(user.posts_counter).to eq(1)
    end
  end
end
