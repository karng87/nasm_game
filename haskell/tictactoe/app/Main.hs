module Main where
import Graphics.Gloss
import Graphics.Gloss.Data.Color
import GHC.Event (Event)
import Data.Array
import GHC.Arr (Array)

data Game = Game{gameBoard:: Board,
                 gamePlayer::Player,
                 gameState:: State
                 } deriving (Eq,Show)
data Player = PlayerX | PlayerO deriving (Eq, Show)                 
data State = Running | GameOver (Maybe Player) deriving (Eq,Show)
type Board = Array(Int,Int) Cell
data Cell = Empty | Full Player deriving (Eq Show)


window :: Display
window = InWindow "Tic Tac Toe" (640, 480) (100, 100)

bgcolor:: Color
bgcolor = makeColor 0 0 0 255

picture :: Float -> Picture
picture _ = Blank 

eventHandler :: Event -> game -> game

main :: IO ()
main = putStrLn "Hello, Haskell!"
