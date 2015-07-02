FactoryGirl.define do
  factory :user do
    email 'alice@example.com'
    password 'abc123!'
    password_confirmation 'abc123!'
  end
end