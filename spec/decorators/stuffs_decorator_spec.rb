require 'spec_helper'

describe StuffsDecorator do

  before :each  do
    2.times { FactoryGirl.create :url_stuff }
    3.times { FactoryGirl.create :picture_stuff }
  end

  describe 'for_showing' do

    it 'return only url stuff if has filter' do
      params = {filter_type: 'UrlStuff'}
      decorator = StuffsDecorator.new(Stuff).with_params(params)
      showing_staff = decorator.for_showing
      type_array = showing_staff.distinct(:type).pluck(:type)
      expect(type_array).to eq ['UrlStuff']
      expect(showing_staff.count).to eq 2
    end

    it 'return only url stuff if has filter' do
      params = {filter_type: 'PictureStuff'}
      decorator = StuffsDecorator.new(Stuff).with_params(params)
      showing_staff = decorator.for_showing
      type_array = showing_staff.distinct(:type).pluck(:type)
      expect(type_array).to eq ['PictureStuff']
      expect(showing_staff.count).to eq 3
    end

  end
end
