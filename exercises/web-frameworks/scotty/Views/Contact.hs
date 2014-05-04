{-# LANGUAGE OverloadedStrings #-}

module Views.Contact (contactView) where

import           Prelude                     hiding (div, head, id)
import           Text.Blaze.Html5            (Html, a, button,
                                              dataAttribute, div, docTypeHtml,
                                              form, h1, h2, head, input, li,
                                              link, meta, p, script, style,
                                              title, ul, (!))
import           Text.Blaze.Html5.Attributes (charset, class_, content, href,
                                              httpEquiv, id, media, name,
                                              placeholder, rel, src, type_)
import           Views.Utils                 (blaze, pet)
import           Web.Scotty                  (ActionM)
import           Views.Layout                (layout)

contactView :: ActionM ()
contactView = blaze $ layout "contact" $ do
             div ! class_ "container" $ do
               div ! class_ "jumbotron" $ do
                 h1 "Contact view"
                 p "Welcome to the Scotty Starter template, equipped with Twitter Bootstrap 3.0 and HTML5 boilerplate"
                 p $ do a ! class_ "btn btn-lg btn-primary" ! id "fb" ! href "#navbar" $ "Facebook"
                        a ! class_ "btn btn-lg btn-danger" ! id "gmail" ! href "#navbar" $ "Gmail"

