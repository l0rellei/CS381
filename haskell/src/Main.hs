module Main where
import System.IO
import Control.Monad
import System.Random
import Data.List
import Data.Char

data State = State {guesses :: Int, word :: String, progress :: String}

main :: IO ()
main = do 
  hSetBuffering stdout NoBuffering -- Might be needed for Mac only.
  randomNum <- randomRIO(0, 6)
  let word = wordBank !! randomNum
  getUserInput (State (length word + 2) word (map (const '_') word))

getUserInput :: State -> IO ()   
getUserInput (State guesses word progress)
    | guesses == 0 = do
        putStrLn("You LOSE! The word was: " <> word)
    | otherwise = do
      putStr "Enter a letter> "
      userInput <- fmap upperCase getLine
      putStrLn ("You guessed: " <> userInput)
      let newProgress = zipWith (updateProgress userInput) progress word
      putStrLn (intersperse ' ' $ newProgress)
      
      if word == newProgress then
        putStrLn("Congratulations, you guessed the word!")
      else if head userInput `elem` word then
        getUserInput(guesses) word newProgress
      else
        getUserInput(guesses - 1) word newProgress -- takes a value and turns it into an IO()

      where
        updateProgress userInput progressChar wordChar
          | progressChar == '_' && head userInput == wordChar = wordChar
          | otherwise = progressChar

        showChar userInput char
          | head userInput == char = char
          | otherwise = '_' 

wordBank :: [String]
wordBank = map upperCase ["Hangman","Rhubarb","Apple","Windows","Linux","Processor","Coalesce"]

upperCase :: String -> String
upperCase = map toUpper