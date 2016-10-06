import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, text, form, input, label, fieldset, img, span)

import Html.App as App
import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src, disabled, style)
import Scroll exposing (Move)
import String

import Content exposing (..)
import Ports exposing (..)
import Form
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
    FormMsg subMsg ->
      let
        ( updatedFormModel, widgetCmd ) =
          Form.update subMsg model.formModel
      in
        ( { model | formModel = updatedFormModel }, Cmd.map FormMsg widgetCmd )
    Scrolling move ->
      let
        newModel = { model | scrollTop = snd(move) }
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
    , section [ class "row" ]
      [ h1 [][ text "Home and banner here"]
      , img [ src "malta.jpg" ] []
      ]
    , section [ class "row" ]
      [ h1 [ id "event" ] [ text "Event description"]
      , eventView
      ]
    , section [ class "row" ]
      [ h1 [ id "registration" ] [ text "Registration"]
      , h2 [] [ text "MaltaJS event" ]
      , App.map FormMsg (Form.view model.formModel)
      , div [ class "form-footer" ]
        [ App.map FormMsg (Form.alertView model.formModel)
        , button 
          [ onClick Register
          , class "btn btn-default"
          , disabled (Form.isFormInvalid model.formModel)
          ] [ text "Sign Up!" ]
        ]
      ]
    , section [ class "row" ]
      [ h1 [ id "venue" ] [ text "Venue"]
      , venueView
      ]
    , section [ class "row" ]
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