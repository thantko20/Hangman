module Loadables
  def generate_word
    File.open('dictionary/dictionary.txt', 'r') do |file|
      word = file.readlines.sample.chomp
      if !word.length.between?(5, 12)
        generate_word
      else
        return word.upcase
      end
    end
  end

  def save_game
    # So this method will turn the object into json
    # I have to save this json into a new file
    # Maybe I create File.new and then write this json into that file and save itlocally
    # So now I know how to write json into a file and save it locally.
    # I have to listen for user's input 'SAVE' during the game and save the file with the name of their choice
    puts "Name your file: "
    name = gets.chomp.to_s
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    state = {'random_word' => @random_word, 'display_word' => @display_word, 'incorrect_letters' => @incorrect_letters, 'guessess' => @guessess }.to_json
    File.open("saved_games/#{name}.json", 'w') do |file|
      file.puts state
    end
  end

  def load_game
    # TODO
  end
end
