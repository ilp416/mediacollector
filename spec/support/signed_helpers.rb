module SignedHelpers
  def user_signed_in?
    visit '/sign_in'
    page.has_text? t('devise.failure.already_authenticated')
  end

  def sign_in(user)
    visit '/sign_in'
    within('#new_user') do
      fill_in 'user_email', :with => 'user@example.com'
      fill_in 'user_password', :with => 'password'
    end
    click_button t('devise.sessions.new.sign_in')
    expect(user_signed_in?).to be true
  end
end
