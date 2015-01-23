FactoryGirl.define do
  factory :user do
    provider "twitter"
    uid "12345"
    sequence(:nickname) { |n| "user#{n}" }
    sequence(:name) { |n| "Tiwtter user{n}" }
    image_url "http://www.gravatar.com/avatar"

    factory :user2 do
      provider "twitter"
      uid "12346"
    end
  end
end
