module Venue exposing ( view )

import Html exposing ( Html, h1, text, section, div, p)


view : Html a
view =
    section []
        [ h1 [] [ text "Venue"]
        , div []
            [ p [] [ text "Super cool Microsoft's Office :-)"]]
        ]