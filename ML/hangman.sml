fun upperCaseString str = String.map Char.toUpper str

fun actualRand maxRand =
  let
      val maxInt = Int.toLarge (Option.valOf Int.maxInt)
      val time = Int.fromLarge (Time.toSeconds (Time.now ()) mod maxInt)
      val randNum = Random.randInt(Random.rand(0, time)) mod maxRand
  in randNum
  end

fun printLn str = (print str; print "\n")

fun zipWith f (x::xs) (y::ys) = (f (x, y)) :: (zipWith f xs ys)
  | zipWith f [] ys = []
  | zipWith f xs [] = []

fun gameLoop secretWord progress guesses =
  let 
      val _ = print "> "
      val userInput = getOpt (TextIO.inputLine TextIO.stdIn, "")
      val firstChar = String.sub (userInput, 0)
      val newProgress = implode (
        zipWith (fn (x, y) => if x = firstChar then x else y) 
        (explode secretWord) 
        (explode progress))
  in
      ( printLn (str firstChar)
      ; printLn (String.translate (fn c => str c ^ " ") newProgress)
      ; if guesses = 0 then
          printLn "You lose"
        else if newProgress = secretWord then
          printLn "You win"
        else
          gameLoop secretWord newProgress (guesses - 1)
      )
  end

fun startGame () =
  let
      val wordBank = map upperCaseString 
          ["Hangman","Rhubarb","Apple","Windows","Linux","Processor","Coalesce"] 
      val secretWord = List.nth(wordBank, actualRand 6)
      val initialProgress = String.map (fn c => #"_") secretWord
      val initialGuesses = String.size initialProgress + 2
  in
      gameLoop secretWord initialProgress initialGuesses
  end

fun s () = startGame ()
