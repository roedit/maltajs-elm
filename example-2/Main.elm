module Main exposing (..)

import Html exposing (Html, text, button, div, section, article, h1, p, a, header, hr, h5, 
                      ol, li, h2, h3, h4, text, form, input, label, fieldset, img, span, h6, footer, button)

import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type_, for, value, class, href, class, required, src, disabled, style)
import Platform.Sub

type alias Model = { hey: Int }
type Msg = AMessage 

-- PROGRAM

main : Program Never Model Msg
main = Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = (\m -> Sub.none)
  }

init : ( Model, Cmd Msg )
init =
    ( { hey = 1 }, Cmd.none )

viewForRender =
  let (initialModel, initialCommand) = init
  in view initialModel

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    AMessage ->
      (model, Cmd.none)
      
-- VIEW

view : Model -> Html Msg
view model =
   div [ id "container" ]
      [ section [ id "home", class "row banner" ]
        [ h2 [] [ text "Malta JS" ]
        , h3 [] [ text "Javascript community in Malta" ]
        , p [] [ text "Talks, meetups, coding sessions, ..." ]
        ]

       , footer [ class "footer" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
          [ div [ class "leftSide" ]
            [ p [] [ text "Copyright Ⓒ MaltaJs 2017 All Rights Reserved" ] ]
          , div [ class "rightSide" ] []
          ]
        ]
      ]
