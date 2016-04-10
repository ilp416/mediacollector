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

  context 'nickname' do
    it 'should contain 6 symbols min' do
      user = FactoryGirl.build :user, nickname: 'qwert'
      expect(user.valid?).to be false
    end

    it 'should contain at least one aphabetical symbol' do
      user = FactoryGirl.build :user, nickname: '123456'
      expect(user.valid?).to be false
    end

    it 'should be uniq' do
      FactoryGirl.create :user, nickname: 'qwerty1'
      user = FactoryGirl.build :user, nickname: 'qwerty1'
      expect(user.valid?).to be true
      expect(user.nickname).not_to eq 'qwerty1'
    end
  end
end
