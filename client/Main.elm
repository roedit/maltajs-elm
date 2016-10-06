import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, text, form, input, label, fieldset, img, span)

import Html.App as App
import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src, disabled, style)
-- import Task exposing (Task)
-- import Json.Decode 
import Scroll exposing (Move)

import Content exposing (..)
import Ports exposing (..)
import Widget
import Shared exposing (..)
import HttpUtils exposing (registerMe)


-- PROGRAM

main = App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Register ->
      ( { model | signed = True }, registerMe model )
    PostSucceed result ->
      ( { model | registered = True }, Cmd.none )
    PostFail error ->
      ( { model | error = "Sorry, there was an error." }, Cmd.none )
    WidgetMsg subMsg ->
      let
        ( updatedWidgetModel, widgetCmd ) =
          Widget.update subMsg model.widgetModel
      in
        ( { model | widgetModel = updatedWidgetModel }, Cmd.map WidgetMsg widgetCmd )
    Scrolling move ->
      let
        newModel = Debug.log "scroll" { model | scrollTop = snd(move) }
      in
        (newModel, Cmd.none)

    
-- VIEW
  
view : Model -> Html Msg
view model =
  article [ class "container-fluid" ]
    [ header
      [ style
          [ ("top", toString model.scrollTop ++ "px") ]
      ]
      [ headerView "" ]
    , section []
      [ h1 [][ text "Home and banner here"]
      , img [ src "malta.jpg" ] []
      ]
    , section []
      [ h1 [ id "event" ] [ text "Event description"]
      , eventView
      ]
    , section []
      [ h1 [ id "registration" ] [ text "Registration"]
      , h2 [] [ text "MaltaJS event" ]
      , App.map WidgetMsg (Widget.view model.widgetModel)
      , div [ class "form-footer" ]
        [ App.map WidgetMsg (Widget.alertView model.widgetModel)
        , button 
          [ onClick Register
          , class "btn btn-default"
          , disabled (Widget.isFormInvalid model.widgetModel)
          ] [ text "Sign Up!" ]
        ]
      ]
    , section []
      [ h1 [ id "venue" ] [ text "Venue"]
      , venueView
      ]
    , section []
      [ h1 [ id "about" ] [ text "MaltaJS"]
      , aboutView
      ]
    ]


-- todo: handle selected section
headerView : String -> Html a 
headerView selected = 
  ol [ class "breadcrumb" ]
  [ li [] [ a [ href "#about" ] [ text "About" ] ]
  , li [] [ a [ href "#event" ] [ text "Event" ] ]
  , li [] [ a [ href "#registration" ] [ text "Registration" ] ]
  , li [] [ a [ href "#venue" ] [ text "Venue" ] ]
  ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ scroll Scrolling ]