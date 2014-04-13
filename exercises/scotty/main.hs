{-# LANGUAGE OverloadedStrings #-}
module Main where

import Text.Hastache
import Web.Scotty.Trans as S
import Web.Scotty.Hastache
import Network.Wai.Middleware.Static

main :: IO ()
main = scottyH' 3000 $ do

  setTemplatesDir "views"
  middleware $ staticPolicy (noDots >-> addBase "static")

  get "/" index
  get "/:word" beamMeUp


beamMeUp :: ActionH' ()
beamMeUp = do
  beam <- param "word"
  setH "action" $ MuVariable (beam :: String)
  -- ^ "action" will be binded to the contents of 'beam'
  hastache "index.html"


index :: ActionH' ()
-- ??: Why is the apostrophe needed here? In "regular" Scotty this would be ActionM,
index = do
  setHeader "Content-Type" "text/html"
  file "views/index.html"