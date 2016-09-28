import Html exposing (Html, text, button, div, section, article)
import Html.App as App
import Html.Events exposing (onClick)

import Home as Home
import Description as Description
import Registration as Registration
import Venue as Venue
import About as About

main = App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

-- MODEL
type alias Model = Bool

model : Model
model =
    False

-- UPDATE
type Msg = SignOn | SignOff

update : Msg -> Model -> Model
update msg model =
    case msg of
        SignOn ->
            True
        SignOff ->
            False

-- VIEW

view : Model -> Html Msg
view model =
  let
    buttonText = if model then "ciao" else "no"
  in
    article []
        [ Home.view
        , Description.view
        , Registration.view
        , div []
            [ button [ onClick SignOn ] [ text buttonText ] ]
        , Venue.view
        , About.view
        ]
