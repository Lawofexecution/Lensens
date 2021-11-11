require "open-uri"
require 'faker'

Booking.destroy_all
UserRole.destroy_all
Ressource.destroy_all
Project.destroy_all
Role.destroy_all
User.destroy_all

company = Role.create!(title: "Company")
individual = Role.create!(title: "Individual")
filmmaker = Role.create!(title: "Filmmaker")
photographer = Role.create!(title: "Photographer")

puts "#{company.title} created "
puts "#{individual.title} created"
puts "#{filmmaker.title} created"
puts "#{photographer.title} created"

file_y = URI.open('https://kitt.lewagon.com/placeholder/users/Lawofexecution')

client = User.new(
  first_name: 'yassine',
  last_name: 'daoudi',
  email: 'yd@lensens.ma',
  password: "password",
  password_confirmation: "password",
  phone_number: '0661234432'
)
client.photo.attach(io: file_y, filename: 'yassine.png', content_type: 'image/png')
client.save!
UserRole.create!(user: client, role: [individual, company].sample)

file_s = URI.open('https://kitt.lewagon.com/placeholder/users/salmakhattabi')
creator = User.new(
  first_name: "salma",
  last_name: "khattabi",
  bio: Faker::Lorem.sentence(word_count: 5),
  email: "sk@lensens.ma",
  password: "password",
  password_confirmation: "password",
  phone_number: "07700000101"
)
creator.photo.attach(io: file_s, filename: 'salma.png', content_type: 'image/png')
creator.save!
user_role = UserRole.create!(user: creator, role: [filmmaker, photographer].sample)
puts "#{creator.first_name} is a #{user_role.role.title}"

executions = 2
executions.times do
  client = User.new(
    first_name: Faker::Name.name,
    last_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    phone_number: Faker::Number
  )
  client.save!
  user_role = UserRole.create!(user:client,role: [individual, company].sample)
  puts "#{client.first_name} is a #{user_role.role.title}"
end

executions = 20
executions.times do
  creator = User.new(
    first_name: Faker::Name.name,
    last_name: Faker::Name.name,
    bio: Faker::Lorem.sentence(word_count: 5),
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    phone_number: Faker::Number
  )
  random_creator = URI.open("https://picsum.photos/200")
  creator.photo.attach(io: random_creator, filename: 'salma.png', content_type: 'image/png')
  creator.save!
  user_role = UserRole.create!(user: creator, role: [filmmaker, photographer].sample)
  puts "#{creator.first_name} is a #{user_role.role.title}"
end

companies = Role.where(title: "Company").first.users
photographers = Role.where(title: "Photographer").first.users
photographers.each do |the_photographer|
  4.times do
    project = Project.create!(
      name: Faker::Company.name,
      description: Faker::Lorem.sentence(word_count: 3),
      category: ['portrait', 'landscape'].sample,
      start_date: Faker::Date.backward(days: 20),
      end_date: Faker::Date.backward(days: 19),
      client: companies.sample,
      creator: the_photographer)
    puts "#{project.name} has been created for #{the_photographer.first_name}"
  end
end
