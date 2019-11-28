require 'open-uri'
require 'json'
require 'faker'

# clean db
puts "clean db start"
puts "delete UserEvents"
UserEvent.delete_all
puts "delete Events"
Event.delete_all
puts "delete Games"
Game.delete_all
puts "delete Users"
User.delete_all


# Creation games
puts "seed games start"
url = 'https://bgg-json.azurewebsites.net/collection/edwalter'
json = open(url).read
list_game = JSON.parse(json)
games = list_game.flatten
i = 0
games.each do |item|
  i += 1
  break if i == 101
  game = Game.new
  game.name = item['name']
  game.rules = Faker::Lorem.sentence
  game.player_max = item['maxPlayers'].to_i
  game.remote_photo_url = item['thumbnail']
  game.save
  end
puts "#{Game.count} games created"

# Creation users
puts "seed users start"
20.times do
  user = User.new
  user.email = Faker::Internet.email
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.remote_photo_url = Faker::Avatar.image(size: "50x50")
  user.save!
  i += 1
end
puts "#{User.count} users created"

# Creation events
puts "seed events start"
users = User.all
games = Game.all
16.times do
  event = Event.new
  event.date = Faker::Date.forward(days: 23)
  event.user = users.sample
  event.game = games.sample
  event.place = Faker::Address.full_address
  event.save
end
puts "#{Event.count} events created"


#recherche dans games
#sample = JSON.load(open(url).read)

#puts 'Creating games...'
#sample['games'].each do |game|
#  Game.create! game.slice('name', 'rules', 'photo', 'player_max')
#end


#puts 'Creating events...'
#sample['events'].each do |event|
#  Event.create! event.slice('date', 'details', 'place').merge(game: games[event["game_slug"]])
#end

# Creation invits
puts "seed invits start"
users = User.all
event = Event.all
20.times do
  invit = UserEvent.new
  invit.user = users.sample
  invit.event = event.sample
  invit.save
end
puts "#{UserEvent.count} invits created"

