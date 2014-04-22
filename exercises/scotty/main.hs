{-# LANGUAGE QuasiQuotes, TemplateHaskell, TypeFamilies #-}
{-# LANGUAGE OverloadedStrings, GADTs, FlexibleContexts #-}
module Main where

import Text.Hastache
import Web.Scotty.Trans as S
import Web.Scotty.Hastache
import Network.Wai.Middleware.Static

{-|
import Control.Monad.IO.Class
import Control.Monad.Logger
import Data.Text (Text, append)
import Data.Time
import Database.Esqueleto
import Database.Persist.Sqlite (runSqlite, runMigration, selectList)
import Database.Persist.TH (mkPersist, mkMigrate, persistLowerCase,
                            share, sqlSettings)
-}
import Data.Text (Text)
import Database.Persist
import Database.Persist.Sqlite (runSqlite, runMigrationSilent)
import Database.Persist.TH (mkPersist, mkMigrate, persistLowerCase,
       share, sqlSettings)
import Database.Persist.Sql (insert)
import Control.Monad.IO.Class (liftIO)


share [mkPersist sqlSettings, mkMigrate "migrateTables"] [persistLowerCase|
Person
  name     Text
  email    Text
  EmailKey email
  deriving Show
|]

buildDb = do
  runMigrationSilent migrateTables
  insert $ Person "Joe" "joe@gmail.com"
  insert $ Person "Ann Author" "anne@example.com"

main = do
  runSqlite ":memory:" $ do
    buildDb
    anne <- getBy $ EmailKey "anne@example.com"
    case anne of
      Nothing -> liftIO $ print "No such user in database."
      Just row -> do
        liftIO $ print "user found"
        liftIO $ print anne
  runServer


runServer :: IO ()
runServer = scottyH' 3000 $ do
  setTemplatesDir "views"
  middleware $ staticPolicy (noDots >-> addBase "static")

  post "/create" createPOST
  S.get "/create" createGET
  S.get "/list" list
  S.get "/" list


createPOST :: ActionH' ()
createPOST = do
  name <- param "name"
  email <- param "email"
  insert $ Person name email
  setH "name" $ MuVariable (name :: Text)
  hastache "show.html"

createGET :: ActionH' ()
createGET = do
  setHeader "Content-Type" "text/html"
  file "views/create.html"


list :: ActionH' ()
list = do
  people <- selectList [] []
  --setH "people" $ MuVariable (people :: [Entity])
  liftIO $ print people
  hastache "list.html"
