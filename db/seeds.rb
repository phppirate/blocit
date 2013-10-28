# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'faker'

# Create 15 topics
topics = []
25.times do
  topics << Topic.create(
      name: Faker::Lorem.words(rand(1..10)).join(" "),
      description: Faker::Lorem.paragraph(rand(1..4))
  )
end

rand(4..10).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: password,
      password_confirmation: password)
  u.skip_confirmation!
  u.save

  rand(15..30).times do
    topic = topics.first # getting the first topic here
    p = u.posts.create(
        topic: topic,
        title: Faker::Lorem.words(rand(1..10)).join(" "),
        body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
    # set the created_at to a time within the past year

    p.update_attribute(:created_at, Time.now - rand(600..31536000))

    p.update_rank
    topics.rotate!

    rand(3..10).times do
      p.comments.create(
          body: Faker::Lorem.paragraphs(rand(1..2)).join("\n"))
    end
  end
end

#u = User.first
#u.skip_reconfirmation!
#u.update_attributes(email: 'vaun@permit.com', password: 'testing123', password_confirmation: 'testing123')

#u = User.new(
#    name: 'Admin User',
#    email: 'admin@example.com',
#    password: 'helloworld',
#    password_confirmation: 'helloworld')
#u.skip_confirmation!
#u.save
#u.update_attribute(:role, 'admin')
#
#u = User.new(
#    name: 'Moderator User',
#    email: 'moderator@example.com',
#    password: 'helloworld',
#    password_confirmation: 'helloworld')
#u.skip_confirmation!
#u.save
#u.update_attribute(:role, 'moderator')
#
#u = User.new(
#    name: 'Member User',
#    email: 'member@example.com',
#    password: 'helloworld',
#    password_confirmation: 'helloworld')
#u.skip_confirmation!
#u.save
#
#
puts "Seed finished"
#puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"