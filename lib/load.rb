module Loadable

  def generate_word
    File.open('dictionary/dictionary.txt', 'r') do |file|
      word = file.readlines.sample.chomp
      unless word.length.between?(5, 12)
        generate_word 
      else 
        return word.upcase
      end
    end
  end

  def load_game
    # TODO
  end
end