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
filmmaker = Role.create!(title: "Vidéaste")
photographer = Role.create!(title: "Photographe")

puts "#{company.title} created "
puts "#{individual.title} created"
puts "#{filmmaker.title} created"
puts "#{photographer.title} created"


puts "Creating yassine's profile"

file_y = URI.open('https://res.cloudinary.com/dncwxfhjw/image/upload/v1636555369/lensens%20/photographe/Yassine_D_1_smnrfv.jpg')

yassine = User.new(
  first_name: 'Yassine',
  bio: Faker::Lorem.sentence(word_count: 100),
  last_name: 'Daoudi',
  email: 'yd@lensens.ma',
  password: "password",
  password_confirmation: "password",
  phone_number: '+212 6 61 234432',
  address: "29,rue constantine Casablanca"
)
yassine.photo.attach(io: file_y, filename: 'yassine.png', content_type: 'image/png')
yassine.save!
UserRole.create!(user: yassine, role: individual)

puts "Yassine's profile created ! "

puts "Creating salma's profile"

file_s = URI.open('https://res.cloudinary.com/dncwxfhjw/image/upload/v1636555618/lensens%20/photographe/Salma_Clr_Le_wagon_wtgbic.jpg')
salma = User.new(
  first_name: "salma",
  last_name: "khattabi",
  bio: Faker::Lorem.sentence(word_count: 100),
  email: "sk@lensens.ma",
  password: "password",
  password_confirmation: "password",
  phone_number: "+212 7 70 240156",
  address: "29,rue zerktouni Casablanca"
)
salma.photo.attach(io: file_s, filename: 'salma.png', content_type: 'image/png')
salma.save!
user_role = UserRole.create!(user: salma, role: photographer)

puts "Salma's profile created ! "

puts "Creating loubna's profile"

file_l = URI.open('https://res.cloudinary.com/dncwxfhjw/image/upload/v1636555622/lensens%20/photographe/Loubna_B_W_-_Tarikarik_Hilali_Talk_Le_wagon_a9yzw5.jpg')
creator = User.new(
  first_name: "loubna",
  last_name: "charrouf",
  bio: Faker::Lorem.sentence(word_count: 100),
  email: "lc@lensens.ma",
  password: "password",
  password_confirmation: "password",
  phone_number: "+212 6 61 540123",
  address: "2,rue roudani Casablanca"
)
creator.photo.attach(io: file_l, filename: 'loubna.png', content_type: 'image/png')
creator.save!
user_role = UserRole.create!(user: creator, role: photographer)

puts "loubna's profile created ! "

executions = 6
executions.times do
  client = User.new(
    first_name: Faker::Name.name.split[0],
    last_name: Faker::Name.name.split[1],
    email: Faker::Internet.email,
    bio: Faker::Lorem.sentence(word_count: 100),
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
  "rue berlin rabat",
  "rue camellia rabat",
  "avenue Mohammed v, Rabat"
]
creator_photos = [
 "https://res.cloudinary.com/dncwxfhjw/image/upload/v1637056254/lensens%20/photographe/marlon-alves-HY7zfjtQz3U-unsplash_tyidjx.jpg",
 "https://res.cloudinary.com/dncwxfhjw/image/upload/v1637056268/lensens%20/photographe/jakob-owens-4jskfbcX--c-unsplash_s1olrk.jpg",
 "https://res.cloudinary.com/dncwxfhjw/image/upload/v1637056262/lensens%20/photographe/marcus-wallis-w5Fyg7SWNFI-unsplash_izszx8.jpg",
  "https://res.cloudinary.com/dncwxfhjw/image/upload/v1636555479/lensens%20/photographe/Photographer_H1_tu2lqc.jpg",
  "https://res.cloudinary.com/dncwxfhjw/image/upload/v1636555610/lensens%20/photographe/ben-parker-OhKElOkQ3RE-unsplash_surdve.jpg",
  "https://res.cloudinary.com/dncwxfhjw/image/upload/v1636555618/lensens%20/photographe/Salma_Clr_Le_wagon_wtgbic.jpg",
  "https://res.cloudinary.com/dncwxfhjw/image/upload/v1636555599/lensens%20/photographe/Photographer_F3_yf3v5o.jpg",
]

creator_addresses.each_with_index do |address, index|
  creator = User.new(
    first_name: Faker::Name.name.split[0],
    last_name: Faker::Name.name.split[1],
    bio: Faker::Lorem.sentence(word_count: 100),
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    phone_number: "+212 6 61 540123",
    address: address
  )
  random_creator = URI.open(creator_photos[index])
  creator.photo.attach(io: random_creator, filename: 'salma.png', content_type: 'image/png')
  creator.save!
  user_role = UserRole.create!(user: creator, role: [filmmaker, photographer].sample)
  puts "#{creator.first_name} is a #{user_role.role.title}"
end

# companies = Role.where(title: "Company").first.users
# photographers = Role.where(title: "Photographe").first.users

# photographers.each do |the_photographer|
#   4.times do
#     project = Project.create!(
#       name: Faker::Company.name,
#       description: Faker::Lorem.sentence(word_count: 3),
#       category: ['portrait', 'landscape'].sample,
#       start_date: Faker::Date.backward(days: 20),
#       end_date: Faker::Date.backward(days: 19),
#       client: companies.sample,
#       creator: the_photographer)
#     puts "#{project.name} has been created for #{the_photographer.first_name}"
#   end
# end
