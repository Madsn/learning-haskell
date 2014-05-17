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
      
      
      get "/ranklists/Teams" $ do
        (Teams :: [Db.Entity Team]) <-
          liftIO $ flip Db.runSqlPersistMPool pool $ Db.selectList [] []
        json Teams

      get "/ranklists/Teams/:id" $ do
        (id :: Integer) <- param "id"
        let key :: Db.Key Team = Db.Key (Db.PersistInt64 $ fromIntegral id)
        (Team :: Maybe Team) <-
          liftIO $ flip Db.runSqlPersistMPool pool $ Db.get $ key
        case Team of
          Just e  -> do setHeader "Access-Control-Allow-Origin" "*"
                        json $ Db.Entity key e 
          Nothing -> status notFound404

      post "/ranklists/Teams" $ do
        e :: Team <- jsonData
        id <- liftIO $ flip Db.runSqlPersistMPool pool $ Db.insert e
        json $ Db.Entity id e

      put "/ranklists/Teams/:id" $ do
        (id :: Integer) <- param "id"
        let key :: Db.Key Team = Db.Key (Db.PersistInt64 $ fromIntegral id)
        e :: Team <- jsonData
        (Team :: Maybe Team) <-
          liftIO $ flip Db.runSqlPersistMPool pool $ Db.get $ key
        case Team of
          Just _  -> do liftIO $ flip Db.runSqlPersistMPool pool $ Db.replace key $ e
                        json $ Db.Entity key e
          Nothing -> status notFound404

      delete "/ranklists/Teams/:id" $ do
        (id :: Integer) <- param "id"
        let key :: Db.Key Team = Db.Key (Db.PersistInt64 $ fromIntegral id)
        (Team :: Maybe Team) <-
          liftIO $ flip Db.runSqlPersistMPool pool $ Db.get $ key
        case Team of
          Just _  -> do liftIO $ flip Db.runSqlPersistMPool pool $ Db.delete $ key
                        status noContent204
          Nothing -> status notFound404
      

      notFound $ do
        status notFound404
        html $ "<h1>Not found :(</h1>"

