import Html exposing (Html, text, button, div, section, article, h1, p)
import Html.App as App
import Html.Events exposing (onClick)

import Registration as Registration

main = App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }

-- MODEL
type alias Model = 
    { signed : Bool
    , user : Registration.Model
    }

model : Model
model = Model False (Registration.Model "" "")


-- UPDATE
type alias Msg = Registration.Msg

update : Msg -> Model -> Model
update msg model =
    model
    {--
    case msg.signed of
        SignOn ->
            True
        SignOff ->
            False --}

-- VIEW

view : Model -> Html Msg
view model =
  let
    buttonText = if model.signed then "Welcome!" else "Sign it, man!"
  in
    article []
        [ section [] [ h1 [][ text "Home and banner here"] ]
        , section []
            [ h1 [] [ text "Event description"]
            , div []
                [ p [] [ text "Fantastic event in Malta, hosted by MaltaJS: will speak about Elm."]]
            ]
        , Registration.view model.user
        , section []
            [ h1 [] [ text "Venue"]
            , div []
                [ p [] [ text "Super cool Microsoft's Office :-)"]]
            ]
        , section []
            [ h1 [] [ text "MaltaJS"]
            , div []
                [ p [] [ text "Bombastic community in Malta!"]]
            ]
       ]
       