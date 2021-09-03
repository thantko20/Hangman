require_relative 'game'

def ask_state
  puts 'Welcome to Hangman! You will be guessing a random word generated by computer.'
  puts "Do you want to load a saved file or start a new game? Type 'NEW' to start a new game. Type 'LOAD' to load a file."
  input = gets.chomp.to_s
  if input.upcase == 'NEW'
    Game.new
  elsif input.upcase == 'LOAD'
    Game.load_game(ask_file)
  end
end

def ask_file
  puts "Here are your saved games: \e[32m#{Dir.entries('saved_games').join(' ')}\e[0m"
  name = gets.chomp.to_s
  if !File.exist?("saved_games/#{name}.json")
    puts 'Type a valid file.'
    ask_file
  else
    name
  end
end

def another_game?
  puts 'Do you want to play again?(Y/n)'
  input = gets.chomp.to_s.downcase
  case input.upcase
  when 'Y'
    true
  when 'N'
    false
  end
end

loop do
  game = ask_state
  game.play
  break unless another_game?
end
