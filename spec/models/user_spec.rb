require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Eduardo') }
  before do
    subject.save
    subject.posts.create(title: 'FIRST', text: 'Tests')
    subject.posts.create(title: 'SECOND', text: 'Tests')
    subject.posts.create(title: 'THIRD', text: 'Tests')
    subject.posts.create(title: 'FORTH', text: 'Tests')
    subject.posts.create(title: 'FIFTH', text: 'Tests')
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts counter should be integer value' do
    subject.posts_counter = 'not valid'
    expect(subject).to_not be_valid
  end

  it 'posts counter should be a number greater or equal to zero' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'recent posts method should return the last three posts' do
    expect(subject.recent_posts.length).to eq(3)
  end
end
