{-# LANGUAGE OverloadedStrings #-}

module Controllers.Home
    ( module Controllers.Home
    ) where

import           Views.Home (homeView)
import           Views.Login (loginView)
import           Views.About (aboutView)
import           Views.Contact (contactView)
import           Web.Scotty (ScottyM, get, html)

home :: ScottyM ()
home = get "/" homeView

login :: ScottyM ()
login = get "/login" loginView

about :: ScottyM ()
about = get "/about" aboutView

contact :: ScottyM ()
contact = get "/contact" contactView
