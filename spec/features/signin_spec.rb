describe 'the signin process', :type => :feature do

  before :each do
    @user = FactoryGirl.create :user,
              email: 'user@example.com',
              password: 'password'
  end

  it 'signs me in' do
    visit '/sign_in'
    within('#new_user') do
      fill_in 'user_email', :with => 'user@example.com'
      fill_in 'user_password', :with => 'password'
    end
    click_button t('devise.sessions.new.sign_in')
    expect(page).to have_content t('devise.sessions.signed_in')
    expect(user_signed_in?).to be true
  end

  it 'can be taken from root page' do
    visit '/'
    expect(page).to have_css 'a[href="/sign_in"]'
  end

  it 'don\'t signs me without password' do
    visit '/sign_in'
    within('#new_user') do
      fill_in 'user_email', :with => 'user@example.com'
    end
    click_button t('devise.sessions.new.sign_in')
    expect(page).to have_content t('devise.failure.invalid')
    expect(user_signed_in?).to be false
  end

  it 'don\'t signs me with wrong password' do
    visit '/sign_in'
    within('#new_user') do
      fill_in 'user_email', :with => 'user@example.com'
      fill_in 'user_password', :with => 'wrongpassword'
    end
    click_button t('devise.sessions.new.sign_in')
    expect(page).to have_content t('devise.failure.invalid')
    expect(user_signed_in?).to be false
  end

end
