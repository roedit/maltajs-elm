import Html exposing (Html, text, button, div, section, article, h1, p, a, header,
                      ol, li, h2, h3, h4, text, form, input, label, fieldset, img, span, h6, footer, button)

import Html.App as App
import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src, disabled, style)
import Platform.Sub
import String
import StickyHeader

import Content exposing (..)
import Ports exposing (..)
import Form
import Shared exposing (..)
import HttpUtils exposing (registerMe)


-- PROGRAM

main : Program Never
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
      let er = Debug.log "Post failed" (toString error) 
      in
      ( { model | error = er }, Cmd.none )
    FormMsg subMsg ->
      let
        ( updatedFormModel, widgetCmd ) =
          Form.update subMsg model.formModel
      in
        ( { model | formModel = updatedFormModel }, Cmd.map FormMsg widgetCmd )
    StickyHeaderMsg subMsg->
      let
        ( updatedHeaderModel, headerCmd ) =
            StickyHeader.update subMsg model.headerModel
      in
        ( { model | headerModel = updatedHeaderModel }
        , Cmd.map StickyHeaderMsg headerCmd
        )

    
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
    div [ class "alert alert-info small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-info-sign" ] []
      , privacyView  
      ]
  
  
view : Model -> Html Msg
view model =
  let
    disableForm = (Form.isFormInvalid model.formModel) || model.registered
  in
    div [ id "container" ]
      [ App.map StickyHeaderMsg (StickyHeader.view model.headerModel)

      , section [ id "home", class "row banner" ]
        [ h2 [] [ text "Malta JS" ]
        , h2 [] [ text "Javascript community in Malta" ]
        , p [] [ text "7th of NOVEMBER | MICROSOFT INNOVATION CENTER" ]
        ]

      , section [ id "subscribe", class "row subscribe" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
          [ h4 [] [ text "Subscribe" ] ]
        , App.map FormMsg (Form.view model.formModel)
        , div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter form-footer" ]
          [ renderAlert model
          , button 
            [ onClick Register
            , class "btn btn-default register"
            , disabled disableForm
            ] [ text "Subscribe" ]
          ]
        ]

      , section [ id "schedule", class "row schedule" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
          [ h4 [] [ text "Schedule" ] ]
        , div []
          [ div [ class "row scheduleRow" ]
            [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
              [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
                [ span [] [ text "12:00" ]
                , span [] [ text "-" ]
                , span [] [ text "14:00" ]
                ]
              , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
                [ text "WELCOME COFFEE & REGISTRATION" ]
              ]
            ]
          ]
        ]

      , section [ id "speakers", class "row speakers" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
          [ h4 [] [ text "Speakers" ] ]
        , div []
          [ div [ class "row" ]
            [ div [ class "col-xs-12 col-sm-4 col-md-4 col-lg-4 speaker" ]
              [ div [ class "content" ]
                [ div [ class "cardFront", style [ ("background-image", "url(/images/speakers/daniel_massa.jpg)") ] ] []
                , div [ class "cardBack" ]
                  [ h6 [] [ text "Daniel Massa" ]
                  , p [ id "speakerPosition" ]
                    [ span []
                      [ text "Frontend Development Lead at"
                      , a [] [ span [] [ text "Sticazzi" ] ]
                      ]
                  , a [ class "linkedin" ] []
                  , p [ id "speakerDescription" ] [ text
                    """
                    Daniel Massa is the Frontend Development Lead at Betsson Group. He is focused on optimizing digital performance with strong focus on business goals. Data, analytics and performance run through his veins. He is committed to always providing with quality, security and state-of-the-art functionality. At Betsson he works with a team of highly specialized professionals to push the limits of on-line gaming.
                    """ ]
                  ]
                ]
              ]
            , div [ class "speakerInfo" ]
              [ h6 [] [ text "Daniel Massa" ]
              , p [] [ text "Frontend Development Lead at Betsson." ]
              , div [ id "speakersCompany" ]
                [ a [] [ img [] [] ] ]
              ]
            ]
          ]
        ]
      ]
    , section [ id "contact", class "row contact" ]
      [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-5 col-md-offset-1 col-lg-5 col-md-offset-1" ]
          [ h4 [] [ text "Contact" ] ]
        , div [ class "col-xs-12 col-sm-6 col-md-6 col-lg-6" ]
          [ div [ class "organizer" ]
            [ div [ class "name" ] [ text "Andrei Toma" ]
            , div [ class "position" ] [ text "Event Organizer" ]
            , div []
              [ span [ class "glyphicon glyphicon-envelope" ] []
              , p [ class "tzuuc@yahoo.com" ] [ text "tzuuc@yahoo.com" ]
              ]
            , div []
              [ span [ class "glyphicon glyphicon-earphone" ] []
              , p [ class "phone" ]
                [ span [] [ text "+" ]
                , span [] [ text "40 744267230" ]
                ]
              ]
            ]
          ]
        ]
      ]
    , section [ id "location", class "row location" ]
      [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
        [ h4 [] [ text "location" ] ]
        --, venueView
      , div [ id "map", class "map-gic" ] []
      ]
    , footer [ class "footer" ]
      [ div [ class "row countdown sticky" ]
        [ div [ class "timer" ] []
        , div [ class "register" ]
          [ a [ href "#subscribe" ] [ text "Subscribe" ] ]
        ]
      , div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
        [ div [ class "leftSide" ]
          [ p [] [ text "Copyright Ⓒ MaltaJs 2015 All Rights Reserved" ] ]
        , div [ class "rightSide" ] []
        ]
      ]
    ]

{--
      , div [ class "container-banner" ]
          [ img [ src "malta.jpg", class "banner" ] [] ]
      , div [ class "main" ]
        [ section [ class "row" ]
          [ h1 [ id "event" ] [ text "Elm and functional programming"]
          , eventView
          ]
        , section [ class "row jumbotron" ]
          [ h1 [ id "registration" ] [ text "Save your seat!"]
          , h3 [] [ text "Saturday 29 October, 12.00" ]
          , App.map FormMsg (Form.view model.formModel)
          , div [ class "form-footer container-fluid" ]
            [ renderAlert model
            , button 
              [ onClick Register
              , class "btn btn-default col-xs-12 col-sm-9"
              , disabled disableForm
              ] [ text "Sign Up!" ]
            ]
          ]
        , section [ class "row" ]
          [ h1 [ id "venue" ] [ text "The venue"]
          , venueView
          ]
        , section [ class "row" ]
          [ h1 [ id "about" ] [ text "MaltaJS"]
          , aboutView
          ]
        ]
      ]
      --}

subscriptions : Model -> Sub Msg
subscriptions model =
    List.map (Platform.Sub.map StickyHeaderMsg) (StickyHeader.subscriptions Ports.scroll model.headerModel)
        |> Sub.batch
