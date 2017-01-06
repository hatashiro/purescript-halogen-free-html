module Main where

import Prelude
import App (app)
import Control.Monad.Eff (Eff)
import Halogen (HalogenEffects, runUI)
import Halogen.Util (awaitBody, runHalogenAff)

main :: Eff (HalogenEffects ()) Unit
main = runHalogenAff do
  body <- awaitBody
  runUI app {} body
