FactoryGirl.define do

  factory :user do
    sequence(:username) { |n| "person_#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    admin false
    blocked false
  end

  factory :session do
    sequence(:user_id) { |n| n }
  end

  factory :bookmark do
    user
    sequence(:title) { |n| "RubyMonk - Interactive Ruby tutorials - #{n}" }
    domain 'rubymonk.com'
    path '/'
  end

end
