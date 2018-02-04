module FaceBookOmniauth
  def self.omniauth_info
    omni_config = OmniAuth.config
    omni_config.test_mode = true
    omni_config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      'provider' => 'facebook', 'uid' => '1234567890',
      'info' => { 'email' => 'user@mail.com', 'name' => 'Vasya Pupkin',
                  'image' => 'Vasya Pupkin img' },
      'credentials' => { 'token' => 'abcdefg12345', 'expires_at' => Time.now, 'expires' => true },
      'extra' => { 'raw_info' => { 'name' => 'Misha Push', 'email' => 'vasulykm@mail.ru',
                                   'id' => '1234567890' } }
    )
  end
end
