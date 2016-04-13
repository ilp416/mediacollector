describe 'stuff', :type => :feature do


  before :each do
    @user = FactoryGirl.create :user,
              email: 'user@example.com',
              password: 'password'

    url_examples = [
      %w(sport.com sport_here),
      %w(movie.com youtube_alternative),
      %w(rutube.com unknown),
      %w(youtube.com movie),
    ]
    url_examples.each do |url, desc|
      FactoryGirl.create :url_stuff,
        target_url: url,
        description: desc,
        user_id: @user.id
    end

    FactoryGirl.create :picture_stuff , user_id: @user.id, description: 'pretty image'
    sign_in @user
    visit "/#{@user.nickname}"
  end

  it 'filterable by type' do
    click_link_to user_staff_path(@user, filter_type: 'UrlStuff')
    expect(page).not_to have_text 'pretty image'
  end

  it 'searchable by description' do
    fill_in 'search', :with => 'youtube'
    click_button 'find'
    expect(page).not_to have_text 'sport.com'
    expect(page).not_to have_text 'pretty image'
    expect(page).to have_text 'youtube.com'
    expect(page).to have_text 'movie.com'
  end

  describe 'showing by pages' do

    before :each do
      # For easy change per_page value
      @per_page = 30
      @user.stuffs.destroy_all
      (@per_page*3).times do |i|
        FactoryGirl.create :url_stuff,
          user_id: @user.id,
          target_url: "url_#{i+1}"
      end
      visit "/#{@user.nickname}"
    end

    it "showing maximum per page items" do
      @user.reload
      last_record = @user.stuffs.last
      last_nth_record = @user.stuffs.last(@per_page).first
      expect(page).to have_text last_record.target_url
      expect(page).not_to have_text last_nth_record
    end

    it 'show next page' do
      click_link t('stuff.load_more')
      paged_stuffs = @user.stuffs.limit(@per_page).offset(@per_page) 
      last_record = paged_stuffs.last
      last_nth_record = paged_stuffs.first
      expect(page).to have_text last_record.target_url
      expect(page).not_to have_text last_nth_record
    end
  end

  context 'no owner user' do
    before :each do
      @owner = FactoryGirl.create :user
      @stuff = FactoryGirl.create :stuff, user_id: @owner.id
      visit user_staff_path @owner
    end
    it 'cannot to add new stuff' do
      expect(page).not_to have_selector "a[href='#{new_stuff_path}']"
    end
    it 'cannot to edit owner\'s stuff' do
      expect(page).not_to have_selector "a[href='#{edit_stuff_path @stuff}']"
    end
    it 'cannot to edit owner\'s stuff' do
      destroy_selector = "a[href='#{stuff_path @stuff}'][method='delete']"
      expect(page).not_to have_selector destroy_selector
    end

  end

end

