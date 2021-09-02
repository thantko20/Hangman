require_relative 'load'

class Game
  include Loadable

  attr_reader :random_word
  attr_accessor :display_word, :incorrect_letters, :guessess
  def initialize
    @random_word = generate_word
    @display_word = Array.new(@random_word.length) { "_" }
    @incorrect_letters = Array.new
    @guessess = 0
  end

  def play
    loop do
      display

      input = ask_input

      puts '--------------------'
      if check_letter?(input)
        reveal_letters(input)
        break if check_word
        next
      end
      @guessess += 1
      @incorrect_letters.push(input)
      
      if @guessess == @random_word.length
        puts "You lost! You are a dead man now! The word is #{@random_word}"
        break
      end
    end
  end

  def display
    puts "You'll have #{random_word.length} chances for incorrect guessess! One letter at a time. Your life depends on this game!\n\n"
    puts "Your previous incorrectly guessed letters: #{@incorrect_letters.join(', ')}"
    puts "Your incorrect guessess: #{@guessess}\n"
    puts @display_word.join(' ')
  end

  def check_letter?(input)
    return true if @random_word.include?(input)
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
    unless input.length == 1
      puts "Enter only one letter"
      ask_input
    else
      return input
    end
  end

  def reveal_letters(input)
    @random_word.split('').each_with_index { |char, i| @display_word[i] = input if char == input}
  end
end