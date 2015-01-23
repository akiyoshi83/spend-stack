FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "category#{n}}" }
    color "#abcdef"
    user
  end

end
