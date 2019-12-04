module Lib where

import Data.List (isPrefixOf)
import Text.ParserCombinators.ReadP (ReadP, choice, readP_to_S, string)
import qualified Text.ParserCombinators.ReadP as Parser 
import Data.Maybe (listToMaybe)

game :: IO ()
game = putStrLn "Hello World"

parse :: String -> Maybe Command
parse = listToMaybe . map fst . readP_to_S (choice [goCommand, lookCommand])

goCommand :: ReadP Command
goCommand = do
    string "go "
    d <- direction
    return $ Go d

lookCommand :: ReadP Command
lookCommand = do
    string "look "
    d <- direction
    return $ Look d

direction :: ReadP Direction
direction = do
    d <- Parser.get
    case d of
        'n' -> return North
        's' -> return South
        'w' -> return West
        'e' -> return East
        _   -> Parser.pfail

data Command = Go Direction
    | Look Direction
    deriving (Show, Eq)
data Direction = North | South | West | East
    deriving (Show, Eq)