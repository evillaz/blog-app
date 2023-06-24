require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Eduardo')
  subject { user.posts.create(title: 'Testing') }
  before { subject.save }

  it 'should update user likes counter' do
    Like.create(author: user, post: subject)
    expect(subject.likes_counter).to eq(1)
  end

  it 'should update user likes counter on post destroy' do
    subject.likes.destroy
    expect(subject.likes_counter).to eq(0)
  end
end
