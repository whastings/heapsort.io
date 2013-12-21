# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do

  # Create some users.
  users = []
  50.times do |n|
    users << User.create!(
      username: Faker::Internet.user_name,
      email: Faker::Internet.email,
      password: 'foobar',
      password_confirmation: 'foobar'
    )
  end

  # Create some bookmarks.
  users.sample(25).each do |user|
    rand(1..10).times do
      user.bookmarks.create!(
        title: Faker::Lorem.sentence(5).titleize,
        url: Faker::Internet.url,
        description: Faker::Lorem.sentences(5).join(' ')
      )
    end
  end

end
