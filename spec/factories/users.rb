FactoryGirl.define do
  sequence :name do |n|
    "user#{n}"
  end

  factory :user do
    name
    password "password"
    password_confirmation "password"
  end
end
