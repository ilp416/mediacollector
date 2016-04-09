require 'rails_helper'

RSpec.describe User, type: :model do
  it 'cannot be created without email' do
    user = FactoryGirl.build :user, email: nil
    expect(user.valid?).to be false
  end
  it 'cannot be created without password' do
    user = FactoryGirl.build :user, password: nil
    expect(user.valid?).to be false
  end
end
