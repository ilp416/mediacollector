describe 'picture_stuff', :type => :feature do

  before :each do
    @user = FactoryGirl.create :user,
              email: 'user@example.com',
              password: 'password'
    sign_in @user
  end

  def create_picture_stuff(args = {})
    args[:picture] = factory_file args[:picture]
    args[:description] ||= 'Awesome resource for searching ))'

    click_link_to '/stuffs/new'
    click_link_to '/picture_stuffs/new'
    attach_file 'stuff_picture', args[:picture]
    fill_in 'stuff_description', :with => args[:description]
    click_button t('Save')
    @stuff = Stuff.last
  end


  it 'can be added as picture' do
    expect {
      create_picture_stuff
    }.to change{PictureStuff.count}.by(1)

    expect(@stuff.picture_file_name).to eq 'rails.jpg'
  end

  context 'after create' do

    before :each do
      create_picture_stuff
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
