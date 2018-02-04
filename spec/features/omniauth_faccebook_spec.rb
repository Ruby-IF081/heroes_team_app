require 'rails_helper'

RSpec.feature 'omniauth facebook' do
  scenario 'fill the sing up form' do
    stub_omniauth
    visit new_user_registration_path
    expect(page).to have_link('Sign up with facebook')
    click_link 'Sign up with facebook'
    expect(page).to have_selector("input[value='Vasya']")
    expect(page).to have_selector("input[value='Pupkin']")
    expect(page).to have_selector("input[value='user@mail.com']")
  end

  scenario 'logs in an existing user' do
    user = create(:user, uid: stub_omniauth.uid, provider: stub_omniauth.provider)
    visit new_user_session_path
    expect(page).to have_link('Facebook')
    click_link 'Facebook'
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content('Successfully authenticated from Facebook account')
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      'provider' => 'facebook',
      'uid' => '1234567890',
      'info' => { 'email' => 'user@mail.com',
                  'name' => 'Vasya Pupkin',
                  'image' => 'Vasya Pupkin img' },
      'credentials' =>
           { 'token' => 'abcdefg12345',
             'expires_at' => DateTime.now,
             'expires' => true },
      'extra' => { 'raw_info' => {
        'name' => 'Misha Push',
        'email' => 'vasulykm@mail.ru',
        'id' => '1234567890'
      } }
    )
  end
end
