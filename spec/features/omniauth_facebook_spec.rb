require 'rails_helper'

RSpec.feature 'omniauth facebook' do
  stub_omniauth_json = JSON.parse(File.read('spec/fixtures/facebook_omniauth.json'))
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(stub_omniauth_json)

  scenario 'fill the sing up form' do
    visit new_user_registration_path
    expect(page).to have_link('Sign up with facebook')
    click_link 'Sign up with facebook'
    expect(page).to have_selector("input[value='Vasya']")
    expect(page).to have_selector("input[value='Pupkin']")
    expect(page).to have_selector("input[value='user@mail.com']")
  end

  scenario 'logs in an existing user' do
    user = create(:user, uid: stub_omniauth_json['uid'], provider: stub_omniauth_json['provider'])
    visit new_user_session_path
    expect(page).to have_link('Facebook')
    click_link 'Facebook'
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
    expect(page).to have_content('Successfully authenticated from Facebook account')
  end
end
