# purescript-halogen-free-html

Free monad for Halogen HTML

## Project status

***Experimental, not ready for common usage.***

I am quite new with PureScript and Halogen, and unsure this idea is viable.
Please feel free to leave your thought and share knowledge in [Issues](https://github.com/noraesae/purescript-halogen-free-html/issues),
or on [Twitter](https://twitter.com/noraesae).

## What's this?

It's experimental usage of [free monad](https://pursuit.purescript.org/packages/purescript-free/3.3.0/docs/Control.Monad.Free)
to render Halogen HTML.

With using free monad, we can write render functions in Halogen components
to be concise and easy to read.

For example, a usual render function with plain Halogen HTML...

``` purescript
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
```

...can be rewritten with free monad like below.

``` purescript
render :: State -> ComponentHTML Query
render _ = renderHTML do
  div do
    h1 $ text "this is header 1."
    h2 $ text "this is header 2."
    p do
      text "just a "
      b $ text "plain"
      text " text"
```

The codes above can also be found in [App](src/App.purs) and [FreeHTML](src/FreeHTML.purs)
modules.

## How to run

Make sure that `purescript`, `pulp`, `bower` and `yarn` (or `npm`) is installed
properly.

``` bash
# clone and cd
git clone https://github.com/noraesae/purescript-halogen-free-html.git
cd purescript-halogen-free-html

# install deps
bower i
yarn

# build
pulp browserify --to output/build.js

# open in browser
open index.html
```

## License

[MIT](LICENSE)
