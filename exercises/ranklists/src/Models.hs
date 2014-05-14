{-# LANGUAGE TemplateHaskell, QuasiQuotes,
             TypeFamilies, EmptyDataDecls,
             FlexibleContexts, FlexibleInstances, GADTs,
             OverloadedStrings #-}

module Models where

import Data.Time (UTCTime)
import Database.Persist.TH

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|

|]
