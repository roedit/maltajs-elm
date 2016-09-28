module About exposing ( view )

import Html exposing ( Html, h1, text, section, div, p)


view : Html a
view =
    section []
        [ h1 [] [ text "MaltaJS"]
        , div []
            [ p [] [ text "Bombastic community in Malta!"]]
        ]