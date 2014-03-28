# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_resource(user, category = nil)
  user.resources.create!(
    title: Faker::Lorem.sentence(5).titleize,
    url: Faker::Internet.url,
    description: Faker::Lorem.sentences(5).join(' '),
    category_id: category.nil? ? nil : category.id
  )
end

def random_seed
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

  # Create some resources.
  resources = []
  users.sample(25).each do |user|
    rand(1..10).times do
      resources << create_resource(user)
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
    resources.sample(rand(1..5)).each do |resource|
      resource.update!(category_id: category.id)
      resources.delete(resource)
    end
  end
end

def create_resource_types
  return unless ResourceType.count == 0
  ResourceType.create!([
    {name: 'Article'},
    {name: 'Book'},
    {name: 'Event'},
    {name: 'Framework'},
    {name: 'Library'},
    {name: 'News Source'},
    {name: 'Presentation'},
    {name: 'Reference'},
    {name: 'Tool'},
    {name: 'Video'}
  ])
end

def create_guest_user
  return if User.find_by(username: 'guest')
  password = SecureRandom.urlsafe_base64
  User.create!(
    username: 'guest',
    email: 'guest@heapsort.io',
    password: password,
    password_confirmation: password
  )
end

ActiveRecord::Base.transaction do

  # random_seed
  create_resource_types
  create_guest_user

end
