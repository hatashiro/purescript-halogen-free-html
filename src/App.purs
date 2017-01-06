module App (
  State,
  Query,
  app
  ) where

import Prelude
import Halogen (Component, ComponentDSL, ComponentHTML, component)
import Halogen.HTML.Indexed as H

type State = {}

data Query a = None a

app :: forall g. Component State Query g
app = component { render, eval }
  where
  render :: State -> ComponentHTML Query
  render _ = H.div_
    [ H.h1_ [ H.text "this is header 1." ]
    , H.h2_ [ H.text "this is header 2." ]
    ]

  eval :: Query ~> ComponentDSL State Query g
  eval (None next) = pure next
