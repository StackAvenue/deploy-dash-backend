require 'rails_helper'

RSpec.describe User, type: :model do
  it "create user" do
    user = build(:user)
    byebug
    user.validate
    expect(user.errors[:git_id]).to include("can't be blank")
  end
  
end
