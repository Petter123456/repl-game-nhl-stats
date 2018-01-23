#Rubygems that we need to to use httparty
require "httparty"
require 'json'
# Get data
url = 'https://nhl-score-api.herokuapp.com/api/scores/latest' # the url for the api
response = HTTParty.get url #Here we are using the httparty gem to actually get the api
data = response.parsed_response # .parsed method gets the data from the api in a structured manner
games = data['games'] #enters hash
date = data['date'] #enters hash

#output date
puts "Date: #{date["pretty"]}"
# list the current games
game_number = 0

games.each do |game|
  teams = game["teams"]
  away_team = teams["away"]
  home_team = teams["home"]
  game_number = game_number + 1
  puts "#{game_number}   #{away_team} @ #{home_team} #{game["state"]}"
end
#this loops back to the beginnning
loop do
  # ask the user to select the game
  puts "Please, select a game using the numbers on the left hand side"
  game_select = gets.chomp.to_i

valid_input = [1,2,3,4,5,6,7,8,9]

if valid_input.include?(game_select)
  # Game Selector
  game = games[game_select - 1]
  away_team = game["teams"]["away"]
  home_team = game["teams"]["home"]

  away_team_record = game["records"][away_team]
  home_team_record = game["records"][home_team]

    puts "#{away_team} #{game["scores"][away_team]}"
    puts "#{home_team} #{game["scores"][home_team]}"
    puts "Game Status: #{game["state"]}"
  # More stats?
  puts "Would you like to see more about the teams stats?"
    stats_response = gets.chomp

  stats_valid_yes = ["y", "Y", "yes", "Yes", "YES"]

  if stats_valid_yes.include?(stats_response)
    puts "#{away_team} Wins: #{away_team_record["wins"]} Losses: #{away_team_record["losses"]} Ties: #{away_team_record["ot"]}"
    puts "#{home_team} Wins: #{home_team_record["wins"]} Losses: #{home_team_record["losses"]} Ties: #{home_team_record["ot"]}"
  end

else
  puts "please enter a correct number corresponding to the game"
  game_select2 = gets.chomp.to_i
end

# Select another game
  puts "Ok, so would you like to see another game"
    response = gets.chomp

  valid_yes = ["y", "Y", "yes", "Yes", "YES"]

  if valid_yes.include?(response)
  else
    puts "thank you for checking the current nhl games"
   break
  end
end
