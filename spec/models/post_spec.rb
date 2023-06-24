require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Eduardo')
  subject { user.posts.create(title: 'Testing') }
  before do
    subject.save
  end

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not exceed 250 characters' do
    expect(subject).to be_valid
  end

  it 'comments counter should be integer value' do
    subject.comments_counter = 'not valid'
    expect(subject).to_not be_valid
  end

  it 'comments counter should be a number greater or equal to zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes counter should be integer value' do
    subject.likes_counter = 'not valid'
    expect(subject).to_not be_valid
  end

  it 'likes counter should be a number greater or equal to zero' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'returns the last five comments on the post' do
    subject.comments.create
    subject.comments.create
    subject.comments.create
    subject.comments.create
    subject.comments.create
    subject.comments.create
    expect(subject.recent_comments.length).to eq(5)
  end

  describe 'update user posts counter method' do
    it 'should update users posts counter' do
      expect(subject.author.posts_counter).to eq(1)
    end

    it 'should update user posts counter on post destroy' do
      subject.destroy
      user.reload
      expect(user.posts_counter).to eq(0)
    end
  end
end
