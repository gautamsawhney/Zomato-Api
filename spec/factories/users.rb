FactoryGirl.define do

  sequence(:email) { |n| "user#{n}@example.com" }
  sequence(:username) { |n| "user#{n}" }
  factory :user do
    email
    username
    password '12345678'
    password_confirmation '12345678'
    #roles :admin
  end

  #roles
  factory :mod, class: User do
    email
    username
    password '12345678'
    password_confirmation '12345678'
    roles :mod
  end
  factory :super_admin, class: User do
    email
    username
    password '12345678'
    password_confirmation '12345678'
    roles :super_admin
  end
  factory :restaurant_owner, class: User do
    email
    username
    password '12345678'
    password_confirmation '12345678'
    roles :restaurant_owner
  end
end
