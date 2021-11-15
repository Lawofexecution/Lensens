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


puts "Creating yassine's profile"

file_y = URI.open('https://kitt.lewagon.com/placeholder/users/Lawofexecution')

client = User.new(
  first_name: 'yassine',
  bio: Faker::Lorem.sentence(word_count: 100),
  last_name: 'daoudi',
  email: 'yd@lensens.ma',
  password: "password",
  password_confirmation: "password",
  phone_number: '0661234432',
  address: "29,rue constantine Casablanca"
)
client.photo.attach(io: file_y, filename: 'yassine.png', content_type: 'image/png')
client.save!

puts "Yassine's profile created ! "

puts "Creating salma's profile"

UserRole.create!(user: client, role: [individual, company].sample)

file_s = URI.open('https://kitt.lewagon.com/placeholder/users/salmakhattabi')
creator = User.new(
  first_name: "salma",
  last_name: "khattabi",
  bio: Faker::Lorem.sentence(word_count: 100),
  email: "sk@lensens.ma",
  password: "password",
  password_confirmation: "password",
  phone_number: "07700000101",
   address: "29,rue zerktouni Casablanca"
)
creator.photo.attach(io: file_s, filename: 'salma.png', content_type: 'image/png')
creator.save!
user_role = UserRole.create!(user: creator, role: photographer)

puts "Salma's profile created ! "

puts "Creating loubna's profile"

file_l = URI.open('https://kitt.lewagon.com/placeholder/users/loucharr')
creator = User.new(
  first_name: "loubna",
  last_name: "charrouf",
  bio: Faker::Lorem.sentence(word_count: 5),
  email: "lc@lensens.ma",
  password: "password",
  password_confirmation: "password",
  phone_number: "07700000101",
   address: "2,rue roudani Casablanca"
)
creator.photo.attach(io: file_l, filename: 'loubna.png', content_type: 'image/png')
creator.save!
user_role = UserRole.create!(user: creator, role: filmmaker)

puts "loubna's profile created ! "

executions = 2
executions.times do
  client = User.new(
    first_name: Faker::Name.name,
    last_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    phone_number: Faker::Number,
    address: "29,rue sebta Casablanca"
  )
  client.save!
  user_role = UserRole.create!(user:client,role: [individual, company].sample)
  puts "#{client.first_name} is a #{user_role.role.title}"
end

creator_addresses = [
  "Anfaplace Mall, Casablanca 20200",
  "rue d'arcachon casablanca 20500",
  "90 bd de la corniche casabalanca",
  "400 bd roudani casablanca",
  " Rabat 10106",
  "rue camellia rabat",
  "ave Mohammed v, Rabat",
  "Bd de Fes, Casablanca 20250"
]
creator_addresses.each do |address|
  creator = User.new(
    first_name: Faker::Name.name,
    last_name: Faker::Name.name,
    bio: Faker::Lorem.sentence(word_count: 5),
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    phone_number: Faker::Number,
    address: "29,rue gauthier Casablanca"
  )
  random_creator = URI.open("https://picsum.photos/500")
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
