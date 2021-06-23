# frozen_string_literal: false

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'create a valid user' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'validates presence of git id' do
    user = build(:user, git_id: nil)
    user.validate
    expect(user.errors[:git_id]).to include("can't be blank")
  end

  it 'validates presence of access_token' do
    user = build(:user, access_token: nil)
    user.validate
    expect(user.errors[:access_token]).to include("can't be blank")
  end

  it 'validates uniqueness access_token' do
    user1 = create(:user)
    user2 = build(:user, access_token: user1[:access_token])
    user2.validate
    expect(user2.errors[:access_token]).to include("has already been taken")
  end

  it 'validates uniqueness git_id' do
    user1 = create(:user)
    user2 = build(:user, git_id: user1[:git_id])
    user2.validate
    expect(user2.errors[:git_id]).to include("has already been taken") 
  end

  it 'validates uniqueness access_token' do
    user1 = create(:user)
    user2 = build(:user, login: user1[:login])
    user2.validate
    expect(user2.errors[:login]).to include("has already been taken")
  end
end
