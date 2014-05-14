{-# LANGUAGE OverloadedStrings, ScopedTypeVariables, RecordWildCards,
             QuasiQuotes, TemplateHaskell #-}

module Main where

import Prelude hiding (product)

import Control.Monad.IO.Class (liftIO)
import qualified Database.Persist.Sqlite as Db
import Network.HTTP.Types
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import Web.Scotty

import Control.Applicative ((<$>), (<*>))

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Text (renderHtml)

import Models

main :: IO()
main = do
  Db.runSqlite "my.db" $ Db.runMigration migrateAll
  -- liftIO $ Db.runSqlite "example.db" insertInitialData
  
  Db.withSqlitePool "my.db" 10 $ \pool ->
    scotty 3000 $ do
      middleware logStdoutDev
      middleware $ staticPolicy (noDots >-> addBase "public")
      get "/" $
        redirect "index.html"
      
      

      notFound $ do
        status notFound404
        html $ "<h1>Not found :(</h1>"

