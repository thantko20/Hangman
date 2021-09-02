require_relative 'game'
require 'pry-byebug'

loop do
  game = Game.new
  game.play
  puts "Do you want to play again?(Y/n)"
  input = gets.chomp.to_s.downcase
  break if input == 'n'
end