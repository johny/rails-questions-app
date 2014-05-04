FactoryGirl.define do

  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'changeme1234'
    password_confirmation 'changeme1234'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end

end
