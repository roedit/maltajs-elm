module Main exposing (..)

import Platform.Sub
import String
import Html exposing (Html, div, img, h2, h3, h4, span, section,  text, p)
import Html.Attributes exposing (class, id, src)

import Content exposing (..)
import Shared exposing (Model)
import View
import Header


-- PROGRAM


main : Program Never Model Msg
main = Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }


init : ( Model, Cmd Msg )
init =
    ( Shared.initialModel, Cmd.none )


initialView = view Shared.initialModel


-- MESSAGE

type Msg
  = ToggleNavigation Bool


-- UPDATE


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ToggleNavigation show ->
      ({ model | showNavigation = show }, Cmd.none )
    
        
view : Model -> Html Msg
view model =
  div [ id "container" ]
    [ View.header model.showNavigation Nothing (\c -> ToggleNavigation (not c))

    , View.banner

    , View.about model

    , View.event model

    , View.footer

    ]



subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
