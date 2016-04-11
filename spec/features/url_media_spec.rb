describe 'stuff', :type => :feature do

  before :each do
    @user = FactoryGirl.create :user,
              email: 'user@example.com',
              password: 'password'
    sign_in @user
  end

  def create_url_stuff(args = {})
    args[:target_url] ||= 'google.com'
    args[:description] ||= 'Awesome resource for searching ))'
    click_link_to '/stuffs/new'
    fill_in 'stuff_target_url', :with => args[:target_url]
    fill_in 'stuff_description', :with => args[:description]
    click_button t('Save')
  end


  it 'can be added as link' do
    expect {
      create_url_stuff target_url: 'gmail.com'
    }.to change{Stuff.count}.by(1)
    expect(Stuff.last.target_url).to eq 'gmail.com'
  end

  context 'after create' do

    before :each do
      create_url_stuff
      @stuff = Stuff.last
    end

    it 'belongs to user by default' do
      expect(@stuff.user).to eq @user
    end

    it 'can be deleted' do
      stuff_id = @stuff.id
      page.find("a[href='#{stuff_path(@stuff)}'][data-method='delete']").click
      expect(Stuff.where id: stuff_id).to be_empty
    end
  end

end
