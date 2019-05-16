fun upperCaseString str = String.map Char.toUpper str

fun actualRand maxRand =
  let
      val maxInt = Int.toLarge (Option.valOf Int.maxInt)
      val time = Int.fromLarge (Time.toSeconds (Time.now ()) mod maxInt)
      val randNum = Random.randInt(Random.rand(0, time)) mod maxRand
  in randNum
  end

val gameLoop =
  let val userInput = TextIO.inputLine TextIO.stdIn
      val _ = print (getOpt(userInput, ""))
      val wordBank = ["Hangman","Rhubarb","Apple","Windows","Linux","Processor","Coalesce"] 
      val uppercaseList = map upperCaseString wordBank
  in
      print (List.nth(wordBank, actualRand 6))
  end