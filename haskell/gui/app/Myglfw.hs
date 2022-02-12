module Myglfw where

import Graphics.Rendering.OpenGL as GL
import Graphics.UI.GLFW as GLFW
import Graphics.Rendering.OpenGL (($=))
import Data.IORef
import Control.Monad
import System.Environment (getArgs, getProgName)

data Action = Action (IO Action)
main :: IO()
main = do
  args <- getArges
  prog <- getProgName
  case args of
    ["active"] -> putStrLn "Running in active mode" >> main' active
    ["passive"] -> putStrLn "Running in passive mode" >> main' passive
    _ -> putStrLn $ "USAGE: " ++ prog ++ " [active|passive]"

main' run = do
  GLFW.initialize
  -- open window
  GLFW.openWindow (GL.Size 400 400) [GLFW.DisplayAlphaBits 8] GLFW.Window
  GLFW.windowTitle $= "GLFW Demo"
  GL.shadeModel $= GL.Smooth
  --enable antialiasing
  GL.lineSmooth $= GL.Enabled
  GL.blend $= GL.Enabled
  GL.blendFunc $= (GL.SrcAlpha, GL.OneMinusSrcAlpha)
  GL.lineWidth $= 1.5
  -- set the color to clear bg
  GL.clearColor $= color4 0 0 0 0

  GLFW.windowSizeCallback $= \ size@(GL.Size w h) ->
    do
      GL.viewport $= (GL.Position 0 0, size)
      GL.matrixMode $= GL.Projection
      GL.loadIdentity
      GL.ortho2D 0 (realToFrac w) (realToFrac h) 0
  lines <- newIORef []
  run lines
  GLFW.closeWindow
  GLFW.terminate

