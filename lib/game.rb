require_relative 'load'

# the game should give the player limit incorrect number of guesses
# computer will choose random word from dictionary and player has to guess it
# How to guess it? One letter per time. If the player's guessed letter is not in the word, decrement the count
# Display should reveal which letters the player has correctly guessed and the position of the letters(eg. _ r o g r a _ _ i n g)
# Update the display after each guess.(if incorrectly guessed?, also show the incorrect letters)
class Game
  include Loadable
  # How would I initialize the game?
  # Guesses count, random_word, display_word, and an array for incorrect letters
  # Guess count will be init at 0, random_word can be generated from the method random_word from Loadable module, 
  # display_word will be init with "_" * length of the random word(No idea about how to do it currently)
  attr_reader :random_word
  attr_accessor :display_word, :incorrect_letters, :guessess
  def initialize
    @random_word = generate_word
    @display_word = Array.new(@random_word.length) { "_" }
    @incorrect_letters = Array.new
    @guessess = 0
  end

  # So there are two possible conditions that a game will end
  # One is player run out of guesses
  # Or the player correctly guess the word
  # So I will play the game using a loop based on these two conditions
  def play
    loop do
      # Have to create the display(I should create it as another method)
      display

      # Ask the player the letter(Allow only one letter and taking the input as case insensitve)
      input = ask_input
      # have to create a method that checks, 
      # if check_letter return false, increment guessess. If true, continue to next loop
      if check_letter(input)
        # I have to create a method for substituting the letter into display_word array
        reveal_letters(input)
        next
      end
      @guessess += 1
      
      if @guessess == @random_word.length
        puts "You lost! You are a dead man now! The word is #{@random_word}"
        break
      end
    end
  end

  # My display method should display intructions, number of guessess left, display_word and incorrect_letters
  def display
    # Intructions(I'm gonna leave this for a while)
    puts "asdfghkl;qwertyuicnxm,z>cnzxm,fldsjflahrioeqhriqw"
    
    # the rest
    puts "Your incorrect guessess: #{@guessess}"
    puts @display_word.join(' ')
    puts @incorrect_letters.join(', ')
  end

  def check_letter(input)
    # if the word includes the input letter, return true
    return true if @random_word.include?(input)
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

  # Gotta diplay the correct letters
  def reveal_letters(input)
    # I will use a loop,
    # using index
    @random_word.split('').each_with_index { |char, i| @display_word[i] = input if char == input}
  end
end