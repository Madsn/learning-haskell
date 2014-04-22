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
  post "/create" createPOST
  get "/create" createGET

index :: ActionH' ()
-- ??: Why is the apostrophe needed here? In "regular" Scotty this would be ActionM,
index = do
  setHeader "Content-Type" "text/html"
  file "views/index.html"


createPOST :: ActionH' ()
createPOST = do
  name <- param "name"
  -- Persist to db
  setH "name" $ MuVariable (name :: String)
  hastache "show.html"

createGET :: ActionH' ()
createGET = do
  setHeader "Content-Type" "text/html"
  file "views/create.html"
