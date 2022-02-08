module Main where

--import Control.Monad
import qualified GI.Gtk as Gtk
--import GI.Gtk.Declarative
--import GI.Gtk.Declarative.App.Simple 

main :: IO ()
main = do
  window <- Gtk.windowNew Gtk.WindowTypeToplevel 
  Gtk.widgetShow window

