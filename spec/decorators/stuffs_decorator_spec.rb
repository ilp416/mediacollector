require 'spec_helper'

describe StuffsDecorator do

  before :each  do
    2.times { FactoryGirl.create :url_stuff }
    3.times { FactoryGirl.create :picture_stuff }
  end

  describe 'apply_filters' do
    it 'return only url stuff' do
      params = {filter_type: 'UrlStuff'}
      decorator = StuffsDecorator.new(Stuff).with_params(params)
      showing_staff = decorator.for_showing
      type_array = showing_staff.distinct(:type).pluck(:type)
      expect(type_array).to eq ['UrlStuff']
      expect(showing_staff.count).to eq 2
    end
    it 'return only picture stuffs' do
      params = {filter_type: 'PictureStuff'}
      decorator = StuffsDecorator.new(Stuff).with_params(params)
      showing_staff = decorator.for_showing
      type_array = showing_staff.distinct(:type).pluck(:type)
      expect(type_array).to eq ['PictureStuff']
      expect(showing_staff.count).to eq 3
    end
  end

  describe 'apply_search' do
    before :each do
      @stuffs_for_find = [
        FactoryGirl.create(:picture_stuff, description: 'find_me'),
        FactoryGirl.create(:url_stuff, target_url: 'http://find.me')
      ]
    end
    it 'return stuff with keyprase in desc or target_url' do
      params = {search: 'find'}
      decorator = StuffsDecorator.new(Stuff).with_params(params)
      showing_staff = decorator.for_showing
      expect(showing_staff.count).to eq 2
      expect(showing_staff).to eq @stuffs_for_find
    end
  end
end
