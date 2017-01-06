module App where

import Prelude hiding (div)
import FreeHTML (renderHTML, div, h1, h2, p, b, text)
import Halogen (Component, ComponentDSL, ComponentHTML, component)
import Halogen.HTML.Indexed as H

type State = {}

data Query a = None a

app :: forall g. Component State Query g
app = component { render, eval }
  where
  -- usual render function with Halogen HTML
  render' :: State -> ComponentHTML Query
  render' _ =
    H.div_
      [ H.h1_ [ H.text "this is header 1." ]
      , H.h2_ [ H.text "this is header 2." ]
      , H.p_
          [ H.text "just a "
          , H.b_ [ H.text "plain" ]
          , H.text " text"
          ]
      ]

  -- render function with free monad
  render :: State -> ComponentHTML Query
  render _ = renderHTML do
    div do
      h1 $ text "this is header 1."
      h2 $ text "this is header 2."
      p do
        text "just a "
        b $ text "plain"
        text " text"

  eval :: Query ~> ComponentDSL State Query g
  eval (None next) = pure next
