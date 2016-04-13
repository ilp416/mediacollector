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
      type_array = showing_staff.pluck(:type).uniq
      expect(type_array).to eq ['UrlStuff']
      expect(showing_staff.count).to eq 2
    end
    it 'return only picture stuffs' do
      params = {filter_type: 'PictureStuff'}
      decorator = StuffsDecorator.new(Stuff).with_params(params)
      showing_staff = decorator.for_showing
      type_array = showing_staff.pluck(:type).uniq
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
      showing_staff = decorator.for_showing.reverse
      expect(showing_staff.count).to eq 2
      expect(showing_staff).to eq @stuffs_for_find
    end
  end

  describe 'apply pagination' do
    before :each do
      @user = FactoryGirl.create :user
      @per_page = 30
      90.times { FactoryGirl.create :stuff, user_id: @user.id }
    end

    it 'show "per_page" count items' do
      showed_staff = StuffsDecorator.new(@user.stuffs).for_showing
      expect(showed_staff.to_a.count).to eq @per_page
    end

  end

end
