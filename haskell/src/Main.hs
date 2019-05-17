{-# LANGUAGE RecordWildCards #-}

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
    let randomWord = wordBank !! randomNum
        initialGuesses = length randomWord + 2
        initialProgress = map (const '_') randomWord
    gameLoop (State initialGuesses randomWord initialProgress)

gameLoop :: State -> IO ()
gameLoop state@(State {..})
    | win state = putStrLn "Congratulations, you guessed the word!"
    | lose state = putStrLn ("You LOSE! The word was: " <> word)
    | otherwise = do
        putStr "Enter a letter> "
        userInput <- getLine
        let guess = toUpper (head userInput)
            newState = update guess state
        render newState guess
        gameLoop newState
  where
    win state@(State {..}) = progress == word
    lose state@(State {..}) = guesses == 0

render :: State -> Char -> IO ()
render state@(State {..}) guess = do
    putStrLn ("You guessed: " <> [guess])
    putStrLn (intersperse ' ' progress)

update :: Char -> State -> State
update guess state@(State {..}) = state { guesses = newGuesses, progress = newProgress }
  where
    newGuesses = if guess `elem` word then guesses else guesses - 1
    newProgress = zipWith (updateProgress guess) progress word
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
