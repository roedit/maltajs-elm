module Registration exposing ( view, Model, Msg )

import Html exposing ( Html, h1, h2, text, section, div, p, form, input, label, button )
import Html.Events exposing (onClick, on)
import Html.Attributes exposing ( id, type', for, value, class )


type alias Model =
    { name : String
    , surname : String
    }

model : Model
model = Model "" ""

type Msg
    = Name String
    | Surname String
    | Register

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }
        Surname surname ->
            { model | surname = surname }
        Register ->
            -- side fx here
            model

view : Model -> Html Msg
view model =
    section []
        [ h1 [] [ text "Registration"]
        , h2 [] [ text "MaltaJS event" ]
        , form [ id "signup-form" ] 
            [ label [ for "name" ] [ text "Name: " ]
            , input [ id "name", type' "text", value model.name ] []
            , label [ for "surname" ] [ text "Surname: " ]
            , input [ id "surname", type' "text", value model.surname ] []
            , button [ onClick Register ] [ text "Sign Up!" ]
            ]
        ]