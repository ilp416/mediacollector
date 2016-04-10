require 'rails_helper'

RSpec.describe Stuff, type: :model do
  context 'is invalid without' do
    it 'target_link' do
      stuff = FactoryGirl.build :url_stuff, target_url: nil
      expect(stuff).not_to be_valid
    end
  end
end
