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
type Board = Array (Int,Int) Cell
data Cell = Empty | Full Player deriving (Eq, Show)

initialGame = Game{
    gameBoard = array ((0,0),(2,2)) $ zip (range ((0,0),(2,2))) (repeat Empty),
    gamePlayer = PlayerX,
    gameState = Running
  }
window :: Display
window = InWindow "Tic Tac Toe" (640, 480) (100, 100)

bgcolor:: Color
bgcolor = makeColor 0 0 0 255

gamePicture :: Game -> Picture
gamePicture game = case gameState game of
    Running -> Blank
    GameOver winner -> color (makeColor 255 50 50 255) (boardAsPicture $ gameBoard game)

boardAsPicture:: Board -> Picture 
boardAsPicture board = pictures [xCellOfBoard board,oCellOfBoard board, boardGrid]

xCellOfBoard :: Board -> Picture 
xCellOfBoard = Blank

oCellOfBoard :: Board -> Picture 
oCellOfBoard = Blank

boardGrid :: Board -> Picture 
boardGrid = Blank

cellsOfBoard :: Board -> Cell -> Picture 
cellsOfBoard board cell cellPicture = 
      $ map (picture cellPicture . fst)
      $ filter (\_,e) -> e == cell
      $ assocs board
main :: IO ()
main = play window bgcolor 30 initialGame gamePicture (\_ game -> game) (const id)
