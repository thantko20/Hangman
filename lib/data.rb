module Helper
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
    puts 'Name your file: '
    name = gets.chomp.to_s
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    state = {'random_word' => @random_word, 'display_word' => @display_word, 'incorrect_letters' => @incorrect_letters, 'guessess' => @guessess }.to_json
    File.open("saved_games/#{name}.json", 'w') do |file|
      file.puts state
    end
  end
end
