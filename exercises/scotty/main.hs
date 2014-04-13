{-# LANGUAGE OverloadedStrings #-}
module Main where

import Text.Hastache
import Web.Scotty.Trans as S
import Web.Scotty.Hastache

main :: IO ()
main = scottyH' 3000 $ do
  setTemplatesDir "views"
  -- ^ Setting up the director with templates
  get "/:word" $ do
    beam <- param "word"
    setH "action" $ MuVariable (beam :: String)
    -- ^ "action" will be binded to the contents of 'beam'
    hastache "index.html"