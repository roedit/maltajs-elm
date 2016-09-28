module Registration exposing ( view )

import Html exposing ( Html, h1, text, section, div, p, form )


view : Html a
view =
    section []
        [ h1 [] [ text "Registration"]
        , form [] []
        ]