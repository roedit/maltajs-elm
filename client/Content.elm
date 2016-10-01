module Content exposing (..)

{-| This module hosts the actual content of the page. Thus can be edited right here,
    using Markdown. 

# Definition
@docs Content

# Common Helpers
@docs aboutView, venueView, eventView

-}

import Html exposing (Html, h1, div, p, text)
import Markdown


{-| Renders the HTML for the About section: what is MaltaJS 

    aboutView
-}
aboutView : Html a
aboutView =
  Markdown.toHtml []
  """
MaltaJS is the new front-end community in Malta: born in 2016 as internal guild at Betsson,
now is open to all the developers on the island.

Our aim is to provide a place to share knowledge and technologies, through meetings and talks.
  """

{-| Renders the HTML for the Venue section: where there will be the event
 
    venueView
-}
venueView : Html a
venueView =
  Markdown.toHtml []
  """
This event will be hosted by Microsoft.
  """
    
{-| Renders the HTML for the Event section: what are we talking about.

    eventView
-}
eventView : Html a
eventView =
  Markdown.toHtml []
  """
We will talk about [Elm](http://elm-lang.org/), a new functional language which compiles to Javascript and
enforce immutability and single source of truth.

The [Redux](https://github.com/reactjs/redux#thanks) project was actually inspired also by the
[Elm Architecture](https://github.com/evancz/elm-architecture-tutorial).
  """