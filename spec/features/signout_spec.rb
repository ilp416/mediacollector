describe 'the signout process', :type => :feature do

  before :each do
    @user = FactoryGirl.create :user,
              email: 'user@example.com',
              password: 'password'
  end

  it 'signs me in' do
    sign_in @user
    expect(user_signed_in?).to be true
    click_link_to '/sign_out'
    expect(user_signed_in?).to be false
  end

end
