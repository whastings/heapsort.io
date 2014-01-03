# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_bookmark(user, category = nil)
  user.bookmarks.create!(
    title: Faker::Lorem.sentence(5).titleize,
    url: Faker::Internet.url,
    description: Faker::Lorem.sentences(5).join(' '),
    category_id: category.nil? ? nil : category.id
  )
end

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
  bookmarks = []
  users.sample(25).each do |user|
    rand(1..10).times do
      bookmarks << create_bookmark(user)
    end
  end

  # Create some categories and child categories.
  categories = []
  5.times do
    categories << Category.create!(name: Faker::Lorem.sentence(3).titleize)
  end
  categories.each do |category|
    rand(3..8).times do
      Category.create!(
        name: Faker::Lorem.sentence(3).titleize,
        parent_id: category.id
      )
    end
    bookmarks.sample(rand(1..5)).each do |bookmark|
      bookmark.update!(category_id: category.id)
      bookmarks.delete(bookmark)
    end
  end

end
