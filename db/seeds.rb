# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require "geocoder"
require "csv"
require "json"
require "open-uri"
require "uri"

KEY = "live_2ksns710uki19DSKhTaEj3Kd0WVPpR8vOA9tw74eU1jrIb87aSOqRvRWl33yKsKr"

if(false)

filepath = "app/assets/adresses.csv"

addressRandom = CSV.read(filepath).sample

# puts "--------"
# print addressRandom
# # puts addressRandom
# puts "--------"

puts "Cleaning database..."
User.destroy_all

puts "Creating Users..."

3.times do 
  name = Faker::Name.name
  user = User.new(
    name: name,
    email: Faker::Internet.email(name: name),
    password: Faker::Internet.password(min_length: 10, special_characters: true)
  )
  user.save!
end

puts "Users done"

puts "Creating advertisings..."

animalType = ["dog", "cat"]

users = User.all

users.each do |user|
  dogName = Faker::

  advert = Advert.new(
    name:
  )
end

puts "Adverts done"


# result = Geocoder.search([addressRandom[13], addressRandom[12]])

# puts result.first.address

puts "Creating my user"

my = User.new(
  name: "Mr A",
  email: "aaaa@gmail.com",
  password: "@Aaaa1234"
)

my.save!

puts "Seeding done"

end

# Test
if (true)

puts "Testing"

User.destroy_all
my = User.new(
  name: "Mr A",
  email: "aaaa@gmail.com",
  password: "@Aaaa1234"
)

my.save!

filepath = "app/assets/adresses.csv"

address = CSV.read(filepath).sample

result = Geocoder.search([address[13], address[12]]).first.address

puts result

# animalType = ["dog", "cat"].sample

# if animalType == "dog"
  name= Faker::Creature::Dog.name
  # breed = Faker::Creature::Dog.breed
  url = "https://api.thedogapi.com/v1/breeds"
  dogs_serialized = URI.open(url).read
  dog = JSON.parse(dogs_serialized).sample
  breed = dog["name"]
  # url = "https://api.thedogapi.com/v1/images/search?limit=10&breed_ids=#{dog["id"]}"
  url = "https://api.thedogapi.com/v1/images/search?limit=10&breed_ids=1"
  images_serialized = URI.open(url).read
  images = JSON.parse(images_serialized).first(4).map {|dog| dog["url"]}

  # images.each_with_index do |imageUrl, i|
  #   # puts imageUrl
  #   download = URI.open(imageUrl)
  #   print download
  #   File.write("dog-#{i+1}.jpg", download)
  # end
  # print images

  advert = Advert.new(
    name: name,
    address: result,
    phone: "00000000000",
    type_ad: "Lost",
    content: "I lost my dog",
    user_id: User.first.id
  )

  images.each_with_index do |imageUrl, i|
    # puts imageUrl
    IO.copy_stream(URI.open(imageUrl), "dog-#{i+1}.jpg")
    file = File.open(Rails.root.join("dog-#{i+1}.jpg"))
    advert.photos.attach(
      io: file,
      filename: "dog-#{i+1}.jpg",
      content_type: 'image/jpg'
    )
    File.delete(file)
  end

  advert.save!
  
  # else
  #   name= Faker::Creature::Cat.name
  #   breed = Faker::Creature::Cat.breed
  # https://api.thecatapi.com/v1/breeds
# end

# puts name
# puts breed

end

# url = "https://api.github.com/users/ssaunier"
# user_serialized = URI.open(url).read
# user = JSON.parse(user_serialized)

# puts "#{user["name"]} - #{user["bio"]}"