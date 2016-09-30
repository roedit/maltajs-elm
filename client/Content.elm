module Content exposing (..)

import Html exposing (Html, h1, div, p, text)
import Markdown

aboutView : Html a
aboutView =
  Markdown.toHtml []
  """
MaltaJS is the new front-end community in Malta: born in 2016 as internal guild at Betsson,
now is open to all the developers on the island.

Our aim is to provide a place to share knowledge and technologies, through meetings and talks.
  """

venueView : Html a
venueView =
  Markdown.toHtml []
  """
This event will be hosted by Microsoft.
  """
    
eventView : Html a
eventView =
  Markdown.toHtml []
  """
We will talk about [Elm](http://elm-lang.org/), a new functional language which compiles to Javascript and
enforce immutability and single source of truth.

The [Redux](https://github.com/reactjs/redux#thanks) project was actually inspired also by the
[Elm Architecture](https://github.com/evancz/elm-architecture-tutorial).
  """