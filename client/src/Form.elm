module Form exposing (..)

import Html exposing (..)
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

update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }
        Surname surname ->
            { model | surname = surname }

view : Model -> Html Msg
view model =
    form [ id "signup-form" ] 
        [ h1 [] [ text "MaltaJS event" ]
        , label [ for "name" ] [ text "Name: " ]
        , input [ id "name", type' "text", value model.name ] []
        , label [ for "surname" ] [ text "Name: " ]
        , input [ id "surname", type' "text", value model.surname ] []
        , div [ class "signup-button" ] [ text "Sign Up!" ]
        ]

