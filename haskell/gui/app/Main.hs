module Main where

import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort (ViewPort)
import Graphics.Gloss.Interface.IO.Game (Event(EventKey), Key (SpecialKey, Char), SpecialKey (KeyDown))

--main :: IO ()
--main = display FullScreen white (Circle 80)
--main = display (InWindow "Window" (200, 200) (10, 10)) yellow (Circle 80)
--main = animate (InWindow "window" (200, 200) (10, 10)) white (\t -> Circle(2*t))

myDisplay :: Display
myDisplay = InWindow "myDisplay" (200, 200) (10, 10)

myColor :: Color
myColor = blue

myPicture :: Picture
myPicture = Circle 80

--main :: IO()
--main = display myDisplay myColor myPicture

myAniFunc :: Float -> Picture
myAniFunc t = Circle (5*t)

--main :: IO()
--main = animate myDisplay myColor myAniFunc

myRate :: Int
myRate = 20

myInitialModel :: (Float,Float)
myInitialModel = (0,0)

myDrawFunc :: (Float,Float) -> Picture
myDrawFunc (theta, _) = Line [(0,0),(50 * cos theta, 50 * sin theta)]

myUpdateFunc :: ViewPort-> Float -> (Float,Float) -> (Float,Float)
myUpdateFunc _ dt (theta, dtheta) = (theta + dt * dtheta, dtheta - dt * cos theta)
{- 
  (0,0) => (0+1*0::0, 0-1*1::-1) -> (0+2*(-1)::-2, -1 - 2 * 1::-3)
-}
--main :: IO()
--main = simulate myDisplay myColor 20 (0,0) myDrawFunc myUpdateFunc
--main = simulate myDisplay myColor 20 (0,0) (\(i,j) -> Line [(0,0),(50*cos i, 50*sin i)]) (\vp dt (i,j) -> (i+dt*j,j-dt*cos i))

myEventHandler:: Event -> (Float,Float) -> (Float,Float)
myEventHandler (EventKey (Char 'j') _ _ _) (x,y) = (x, y-10)
myEventHandler (EventKey (Char 'k') _ _ _) (x,y) = (x, y+10)
myEventHandler (EventKey (Char 'h') _ _ _) (x,y) = (x-10, y)
myEventHandler (EventKey (Char 'l') _ _ _) (x,y) = (x+10, y)
myEventHandler (EventKey (SpecialKey KeyDown) _ _ _) (x,y) = (x,y-10)
myEventHandler _ w = w

main::IO()
main= play 
  (InWindow "mywin" (200, 200) (10, 10))
  white 
  20 
  (0,0) 
  (\(x,y) -> translate x y (Circle 20))
  --(\(EventKey (Char 'j') _ _ _) (x,y) -> (x,y-10))
  myEventHandler
  (\_ (x,y) -> (x,y))
