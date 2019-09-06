FactoryBot.define do
  factory :user do 
      username { Faker::Name.name }
      password { 'straws' }
      session_token { User.generate_session_token }
  end

  factory :fake_user do 
      username { Faker::Name.name }
      password { 'flaws' }
      session_token { nil }
  end
end

    