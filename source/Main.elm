module Main exposing (..)
import Html exposing (Html, text, button, div, section, article, h1, p, a, header, hr, h5, 
                      ol, li, h2, h3, h4, text, form, input, label, fieldset, img, span, h6, footer, button)

import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type_, for, value, class, href, class, required, src, disabled, style)
import Platform.Sub
import String
import StickyHeader

import Content exposing (..)
import Form
import Shared exposing (..)
import HttpUtils exposing (registerMe)


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
    ( initialModel, Cmd.none )

initialView = view initialModel

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Register ->
      let signed = Debug.log "signed" (not model.signed)
      in
        ( { model | signed = signed }, registerMe model )
    PostResult (Ok result) ->
        ( { model | registered = True }, Cmd.none )
    PostResult (Err error) ->
      let er = Debug.log "Post failed" (toString error) 
      in
      ( { model | error = er }, Cmd.none )
    FormMsg subMsg ->
      let
        ( updatedFormModel, widgetCmd ) =
          Form.update subMsg model.formModel
      in
        ( { model | formModel = updatedFormModel }, Cmd.map FormMsg widgetCmd )

    
-- VIEW

renderAlert : Model -> Html Msg
renderAlert model =
  if (Form.isFormInvalid model.formModel) then
    div [ class "alert alert-danger small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
      , formErrorView
      ]
  else if not((String.isEmpty model.error)) then
    div [ class "alert alert-danger small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
      , p [] [ text "We apologize, something went wrong." ]
      , p [ class "hide" ] [ text model.error ]
      ]
  else if (model.registered) then
    div [ class "alert alert-success small" ]
    [ span [ class "glyphicon glyphicon-info-sign" ] []
    , p [] [ text "You're registered for the event!" ]  
    ]
  else
    Html.text ""
        {--
    div [ class "alert alert-info small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-info-sign" ] []
      , privacyView  
      ] --}
  
viewHeader : Bool -> Maybe Int -> Html Msg
viewHeader headerCollapsed active  =
  let
    brand = StickyHeader.buildItem "MaltaJS" [ "brand" ]
    logo =
      StickyHeader.buildLogo
        (img [ src "images/logo.jpg" ] []) [ "header-logo" ]
    links =
        List.map 
            (\(title, url) -> StickyHeader.buildActiveItem title url [])
            [ ]
    config : StickyHeader.Config Msg
    config = StickyHeader.Config (Just logo) (Just brand) links
  in
    StickyHeader.view config headerCollapsed active

  
view : Model -> Html Msg
view model =
  let
    disableForm = (Form.isFormInvalid model.formModel) || model.registered
  in
    div [ id "container" ]
      [ viewHeader False Nothing

      , section [ id "home", class "row banner" ]
        [ h2 [] [ text "Malta JS" ]
        , h3 [] [ text "Javascript community in Malta" ]
        , p [] [ text "Talks, meetups, coding sessions, ..." ]
        ]

      , viewAbout model
      , div [] [ text (toString model) ]
      , button [ onClick Register ] [ text "Button" ]

      , footer [ class "footer" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
          [ div [ class "leftSide" ]
            [ p [] [ text "Copyright Ⓒ MaltaJs 2017 All Rights Reserved" ] ]
          , div [ class "rightSide" ] []
          ]
        ]
      ]

viewAbout : Model -> Html Msg
viewAbout model =
     section [ id "about", class "row about" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
          [ h4 [] [ text "About" ] ]
        , div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
          [ Content.aboutView ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
