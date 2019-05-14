module Main where

import System.IO
import Control.Monad
import System.Random
import Data.List
import Data.Char

data State = State {
    guesses :: Int,
    word :: String,
    progress :: String
}

main :: IO ()
main = do 
  hSetBuffering stdout NoBuffering
  randomNum <- randomRIO (0, 6)
  let word = wordBank !! randomNum
  gameLoop (State (length word + 2) word (map (const '_') word))

gameLoop :: State -> IO ()
gameLoop (State 0 word _) = putStrLn ("You LOSE! The word was: " <> word)
gameLoop (State guesses word progress) = do
    putStr "Enter a letter> "
    userInput <- fmap uppercase getLine
    putStrLn ("You guessed: " <> userInput)
    let guess = head userInput
    let newProgress = zipWith (updateProgress guess) progress word
    putStrLn (intersperse ' ' newProgress)

    if word == newProgress then
        putStrLn("Congratulations, you guessed the word!")
    else if guess `elem` word then
        gameLoop (State guesses word newProgress)
    else
        gameLoop (State (guesses - 1) word newProgress)

  where
    updateProgress guess progressChar wordChar
        | progressChar == '_' && guess == wordChar = wordChar
        | otherwise = progressChar

wordBank :: [String]
wordBank = map uppercase
    [ "Hangman"
    , "Rhubarb"
    , "Apple"
    , "Windows"
    , "Linux"
    , "Processor"
    , "Coalesce"
    ]

uppercase :: String -> String
uppercase = map toUpper
