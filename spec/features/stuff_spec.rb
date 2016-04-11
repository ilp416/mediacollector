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
    expect(page).not_to have_text('pretty image')
  end

  it 'searchable by description' do
    fill_in 'search', :with => 'youtube'
    click_button t('Find')
    expect(page).not_to have_text('sport.com')
    expect(page).not_to have_text('pretty image')
    expect(page).to have_text('youtube.com')
    expect(page).to have_text('movie.com')
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
      expect(page).to have_text("url_#{@per_page}")
      expect(page).not_to have_text("url_#{@per_page+1}")
    end

    it 'show next page' do
      click_link t('stuff.load_more')
      expect(page).to have_text("url_#{@per_page*2}")
      expect(page).not_to have_text("url_#{@per_page*2+1}")
    end
  end

end

