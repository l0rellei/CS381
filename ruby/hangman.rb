class Hangman
  attr_accessor :word_bank, :word, :game_progress

  def initialize 
    @word_bank = ["Hangman","Rhubarb","Apple","Windows","Linux","Processor","Coalesce"].map { |e| e.upcase }
    @word = word_bank.to_a.sample.chars
    @game_progress = word.map{"_ "}
  end

  def word_string
    return word.join
  end

  def game_progress_string
    return game_progress.join
  end

  def get_upcase_letter
    return gets.chomp.upcase
  end

  def get_guess_num
    return word.length + 2
  end

  def new_game_progress(letter)
    game_progress.each_index.map { |i| game_progress[i] = letter if word[i] == letter }
  end

  def print_game_progress
    puts game_progress.join + "\n"
  end

  def play
    guess_num = get_guess_num

    loop do
      puts "Enter a letter: \n"
      letter = get_upcase_letter()
      new_game_progress(letter)
      if game_progress == word
        print_game_progress
        puts "Congratulations! You won!"
        break
      end
      if word.include?(letter)
        print_game_progress
      else
        guess_num != 1 ? (guess_num = guess_num - 1) : (puts "You Lose! The word was #{word.join}" ; break)
        print_game_progress
      end
    end
  end
end

hangman = Hangman.new
hangman.word_string
puts hangman.game_progress_string
puts "You have #{hangman.get_guess_num} guesses to win to the game."
hangman.play
