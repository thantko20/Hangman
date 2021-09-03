require_relative 'load'
require 'json'

class Game
  include Loadables

  # So I have to initialize the game from start if the user doesn't want to load saved files
  # So I'm gonna give init method default parameters
  attr_reader :random_word, :display_word, :incorrect_letters, :guessess

  def initialize(word=generate_word, display_word=Array.new(word.length) { '_' }, incorrect=[], guessess=0)
    @random_word = word
    @display_word = display_word
    @incorrect_letters = incorrect
    @guessess = guessess
  end

  def play
    loop do
      display
      input = ask_input
      break if input.nil?

      puts '--------------------'
      if check_letter?(input)
        reveal_letters(input)
        break if check_word

        next
      end
      @guessess += 1

      break if check_guess_count?
    end
  end

  def display
    puts "You'll have #{random_word.length} chances for incorrect guessess! One letter at a time. Your life depends on this game!\n\n"
    puts "Your previous incorrectly guessed letters: \e[36m#{@incorrect_letters.join(', ')}\e[0m"
    puts "Your incorrect guessess: #{@guessess}\n"
    puts @display_word.join(' ')
  end

  def check_letter?(input)
    return true if @random_word.include?(input)

    @incorrect_letters.push(input)
    false
  end

  def check_word
    if @display_word.join('') == @random_word
      puts "Correct! The word is #{@random_word}. You will remain alive for this time."
      return true
    end
    false
  end

  def ask_input
    input = gets.chomp.to_s.upcase
    if input.upcase == 'SAVE'
      save_game
    elsif !input.length == 1
      puts 'Enter only one letter'
      ask_input
    else
      input
    end
  end

  def reveal_letters(input)
    @random_word.split('').each_with_index { |char, i| @display_word[i] = input if char == input }
  end

  def check_guess_count?
    if @guessess == @random_word.length
      puts "You lost! You are a dead man now! The word is #{@random_word}"
      return true
    end
    false
  end
end
