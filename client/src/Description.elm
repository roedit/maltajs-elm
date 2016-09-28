module Description exposing ( view )

import Html exposing ( Html, h1, text, section, div, p)


view : Html a
view =
    section []
        [ h1 [] [ text "Event description"]
        , div []
            [ p [] [ text "Fantastic event in Malta, hosted by MaltaJS: will speak about Elm."]]
        ]