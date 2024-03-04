require 'faker'
require "geocoder"
require "csv"
require "json"
require "open-uri"
require "uri"

KEY = "live_2ksns710uki19DSKhTaEj3Kd0WVPpR8vOA9tw74eU1jrIb87aSOqRvRWl33yKsKr"

# Save one image to a model
def modelImage(url, model)
  IO.copy_stream(URI.open(url), "image.jpg")
  file = File.open(Rails.root.join("image.jpg"))
  model.photo.attach(
    io: file,
    filename: "image.jpg",
    content_type: 'image/jpg'
  )
  File.delete(file)
end

def getBreedAndImages(url)
  # serialized = URI.open(url).read
  serialized = URI.open("#{url}/breeds").read
  animal = JSON.parse(serialized).sample
  breed = animal["name"]
  urlImg = "#{url}/images/search?limit=10&breed_ids=#{animal["id"]}"
  # urlImg = "#{url}/images/search?limit=10&breed_ids=abys"
  images_serialized = URI.open(urlImg).read
  images = JSON.parse(images_serialized).first(4).map {|animal| animal["url"]}
  return {breed: breed, images: images}
end

def saveModelImages(images, model)
  images.each do |imageUrl|
    # puts imageUrl
    IO.copy_stream(URI.open(imageUrl), "image.jpg")
    file = File.open(Rails.root.join("image.jpg"))
    model.photos.attach(
      io: file,
      filename: "image.jpg",
      content_type: 'image/jpg'
    )
    File.delete(file)
  end
end

def contentByType(name, breed,animal, type)
  case type
  when "Lost"
    content = "Hi, I lost my #{animal}, #{name}. It's a #{breed.downcase}. Please help me to find it."
  when "Find"
    content = "Hi, I found a #{animal}, looks like a #{breed.downcase}, near my house. Its name is #{name}. Contact me if you know anything."
  when "See"
    content = "Hi, I saw a #{animal} to this address. It looks like a #{breed.downcase}. I hope it helps someone."
  else
    puts 'Error from contentByType from seed'
  end
  content
end

def getFakeComments()
  serialized = URI.open('https://dummyjson.com/comments').read
  comments = JSON.parse(serialized)["comments"]
end

if(true)

filepath = "app/assets/adresses.csv"

addresses = CSV.read(filepath).sample(40)

puts "Cleaning database..."
User.destroy_all

puts "Creating Users..."

38.times do 
  name = Faker::Name.name
  user = User.new(
    name: name,
    email: Faker::Internet.email(name: name),
    password: Faker::Internet.password(min_length: 10, special_characters: true)
  )
  modelImage("https://i.pravatar.cc/300", user)
  user.save!
end

puts "Creating my user..."
my = User.new(
  name: "Mr A",
  email: "aaaa@gmail.com",
  password: "@Aaaa1234"
)
modelImage("https://i.pravatar.cc/300", my)
my.save!

other = User.new(
  name: "Mr B",
  email: "bbbb@gmail.com",
  password: "@Bbbb1234"
)
modelImage("https://i.pravatar.cc/300", other)
my.save!

puts "Users done"

puts "Creating advertisings..."

users = User.all

users.each_with_index do |user, i|
  animalType = ["dog", "cat"].sample
  type = ['Lost', 'Find', 'See'].sample
  if animalType == "dog"
    name= Faker::Creature::Dog.name
    url = "https://api.thedogapi.com/v1"
  
    dog = getBreedAndImages(url)

    address = Geocoder.search([addresses[i][13], addresses[i][12]]).first.address

    Faker::Config.locale = 'en-CA'
    advert = Advert.new(
      name: name,
      address: address,
      phone: Faker::PhoneNumber.phone_number.first(12),
      type_ad: type,
      content: contentByType(name, dog[:breed], animalType, type),
      user_id: user.id
    )
    saveModelImages(dog[:images], advert)
  
    advert.save!
  else
    name= Faker::Creature::Cat.name
    url = "https://api.thecatapi.com/v1"
    cat = getBreedAndImages(url)
  
    address = Geocoder.search([addresses[i][13], addresses[i][12]]).first.address

    Faker::Config.locale = 'en-CA'
    advert = Advert.new(
      name: name,
      address: address,
      phone: Faker::PhoneNumber.phone_number.first(12),
      type_ad: type,
      content: contentByType(name, cat[:breed], animalType, type),
      user_id: user.id
    )
    saveModelImages(cat[:images], advert)
    advert.save!
    sleep(0.5)
  end

  comments = getFakeComments()

  # puts "Advert id"
  # puts advert.id

  5.times do |i|
    comment = Comment.new(
      user_id: users.sample.id,
      advert_id: advert.id,
      content: comments.sample['body']
    )
    comment.save!
  end
end

puts "Adverts done"


# result = Geocoder.search([addressRandom[13], addressRandom[12]])

# puts result.first.address

end

# Test
if (false)

puts "Testing"

def getFakeComments()
  serialized = URI.open('https://dummyjson.com/comments').read
  comments = JSON.parse(serialized)["comments"]
end
comments =  getFakeComments()
(1..3).each {|i| puts comments.sample["body"]}
end

# 'https://dummyjson.com/comments'

# User.order("RANDOM()").first

# sleep(4.minutes)
# # or, even longer...
# sleep(2.hours); sleep(3.days) # etc., etc.
# # or shorter
# sleep(0.5) # half a second