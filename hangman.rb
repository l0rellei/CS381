class Hangman
	attr_accessor :wordBank, :word, :gameProgress

	def initialize 
		@wordBank = ["Hangman","Rhubarb","Apple","Windows","Linux","Processor","Coalesce"].map { |e| e.upcase }
		@word = wordBank.to_a.sample.chars
		@gameProgress = word.map{"_ "}
	end

	def wordString
		return word.join
	end

	def gameProgressString
		return gameProgress.join
	end

	def getUpcaseLetter
		return gets.chomp.upcase
	end

	def getGuessNum
		return word.length + 2
	end

	def newGameProgress(letter)
		gameProgress.each_index.map { |i| gameProgress[i] = letter if word[i] == letter }
	end

	def printGameProgress
		puts gameProgress.join + "\n"
	end

	def play
		guessNum = getGuessNum
		getGuessNum.times do
			puts "Enter a letter: \n"
		 	letter = getUpcaseLetter()
		 	newGameProgress(letter)
		  if gameProgress == word
		 		printGameProgress
		  	puts "Congratulations! You won!"
		  	break
		  end
			guessNum = guessNum - 1
			printGameProgress
		end
		puts "You Lose!"
	end

end

hangman = Hangman.new
puts hangman.wordString
puts hangman.gameProgressString
puts "You have #{hangman.getGuessNum} guesses to win to the game."
hangman.play
