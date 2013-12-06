FactoryGirl.define do

  factory :user do
    sequence(:username) { |n| "person_#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    admin false
    blocked false
  end

end
