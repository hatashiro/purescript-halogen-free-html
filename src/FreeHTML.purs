module FreeHTML where

import Prelude
import Control.Monad.Free (Free, liftF, runFree)
import Data.Array (snoc)
import Data.Array.Partial (head)
import Halogen (HTML)
import Halogen.HTML.Indexed as H
import Partial.Unsafe (unsafePartial)

data FreeHTMLF p i a = HTMLF (HTML p i) a
                     | TextF String a

derive instance functorFreeHTMLF :: Functor (FreeHTMLF p i)

type FreeHTML p i = Free (FreeHTMLF p i)

type Result p i = Array (HTML p i)

interpret :: forall p i.
           FreeHTMLF p i (FreeHTML p i (Result p i))
        -> FreeHTML p i (Result p i)
interpret (HTMLF html next) = flip snoc html <$> next
interpret (TextF str next) = flip snoc (H.text str) <$> next

makeFree :: forall p i.
            (Array (HTML p i) -> HTML p i) -- usual Halogen element_
         -> FreeHTML p i (Result p i)
         -> FreeHTML p i (Result p i)
makeFree el fhtml = liftF (HTMLF (el children) [])
  where children = runFree interpret fhtml

renderHTML :: forall p i. FreeHTML p i (Result p i) -> HTML p i
renderHTML fhtml = unsafePartial head $ runFree interpret fhtml

div :: forall p i. FreeHTML p i (Result p i) -> FreeHTML p i (Result p i)
div = makeFree H.div_

h1 :: forall p i. FreeHTML p i (Result p i) -> FreeHTML p i (Result p i)
h1 = makeFree H.h1_

h2 :: forall p i. FreeHTML p i (Result p i) -> FreeHTML p i (Result p i)
h2 = makeFree H.h2_

p :: forall p i. FreeHTML p i (Result p i) -> FreeHTML p i (Result p i)
p = makeFree H.p_

b :: forall p i. FreeHTML p i (Result p i) -> FreeHTML p i (Result p i)
b = makeFree H.b_

text :: forall p i. String -> FreeHTML p i (Result p i)
text str = liftF (TextF str [])
