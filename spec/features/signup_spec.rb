describe 'the signup process', :type => :feature do

  it 'signing_up will create new user' do
    expect {
      visit '/sign_up'
      within('#new_user') do
        fill_in 'user_email', :with => 'user@example.com'
        fill_in 'user_password', :with => 'password'
        fill_in 'user_password_confirmation', :with => 'password'
      end
      click_button t('devise.registrations.new.sign_up')
    }.to change{User.count}.by(1)
    expect(User.last.email).to eq 'user@example.com'
  end

  it 'after signing up user will logged in' do
    visit '/sign_up'
    within('#new_user') do
      fill_in 'user_email', :with => 'user@example.com'
      fill_in 'user_password', :with => 'password'
      fill_in 'user_password_confirmation', :with => 'password'
    end
    click_button t('devise.registrations.new.sign_up')
    expect(user_signed_in?).to be true
  end

  it 'can be taken from root page' do
    visit '/'
    expect(page).to have_css 'a[href="/sign_up"]'
  end

end
