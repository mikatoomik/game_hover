require 'open-uri'
require 'json'

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
  break if i == 31
  game = Game.new
  game.name = item['name']
  game.player_max = item['maxPlayers'].to_i
  game.remote_photo_url = item['thumbnail']
  game.save
  end
puts "#{Game.count} games created"

# Creation users
puts "seed users start"
10.times do
  user = User.new
  user.email = "test+#{i}@example.com"
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.remote_photo_url = "https://avatars2.githubusercontent.com/u/55501431?s=460&v=4"
  user.save!
  i += 1
end
puts "#{User.count} users created"

# Creation events
puts "seed events start"
users = User.all
games = Game.all
villes = ['Nice', 'Marseille', 'Toulon']
6.times do
  event = Event.new
  event.date = Date.today
  event.user = users.sample
  event.game = games.sample
  event.place = villes.sample
  event.save
end
puts "#{Event.count} events created"

#recherche dans games
sample = JSON.load(open(url).read)

puts 'Creating games...'
sample['games'].each do |game|
  Game.create! game.slice('name', 'rules', 'photo', 'player_max')
end


puts 'Creating events...'
sample['events'].each do |event|
  Event.create! event.slice('date', 'details', 'place').merge(game: games[event["game_slug"]])
end
