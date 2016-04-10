require 'rails_helper'

RSpec.describe Stuff, type: :model do
  context 'is invalid without' do
    it 'user_id' do
      stuff = FactoryGirl.build :picture_stuff, user_id: nil
      expect(stuff).not_to be_valid
    end

    it 'type' do
      stuff = FactoryGirl.build :picture_stuff, type: nil
      expect(stuff).not_to be_valid
    end

    it 'picture' do
      stuff = FactoryGirl.build :picture_stuff, picture: nil
      expect(stuff).not_to be_valid
    end
  end
end
