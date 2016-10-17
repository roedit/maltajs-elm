import Html exposing (Html, text, button, div, section, article, h1, p, a, header, hr, h5, 
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
    Html.text ""
        {--
    div [ class "alert alert-info small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-info-sign" ] []
      , privacyView  
      ] --}
  
  
view : Model -> Html Msg
view model =
  let
    disableForm = (Form.isFormInvalid model.formModel) || model.registered
  in
    div [ id "container" ]
      [ App.map StickyHeaderMsg (StickyHeader.view model.headerModel)

      , section [ id "home", class "row banner" ]
        [ h2 [] [ text "Malta JS" ]
        , h3 [] [ text "Javascript community in Malta" ]
        , p [] [ text "29th of OCTOBER | MICROSOFT INNOVATION CENTER" ]
        ]

      , section [ id "subscribe", class "row subscribe" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
          [ h4 [] [ text "Subscribe" ], h6 [] [ text "Only 30 seats available." ] ]
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
                , span [] [ text "12:15" ]
                ]
              , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
                [ text "WELCOME COFFEE & REGISTRATION" ]
              ]
            ]
          , div [ class "row scheduleRow" ]
            [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
              [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
                [ span [] [ text "12:15" ]
                , span [] [ text "-" ]
                , span [] [ text "12:30" ]
                ]
              , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
                [ text "Welcome speech" ]
              ]
            ]
          , div [ class "row scheduleRow" ]
            [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle" ]
              [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
                [ span [] [ text "12:30" ]
                , span [] [ text "-" ]
                , span [] [ text "13:30" ]
                ]
              , div [ class "col-xs-8 col-sm-10 col-md-10 col-lg-10 eventLine" ] [ hr [] [] ]
              ]
            , div [ class "col-xs-12 col-sm-9 col-md-9 col-lg-9 col-sm-offset-3 col-md-offset-3 col-lg-offset-3 eventSpeaker" ]
              [ div [ class "speakerImg", style [ ("background-image", "url(/images/speakers/pietro_grandi.jpg)") ] ] []
              , h5 []
                [ span [] [ text "Elm: frontend code without runtime exceptions" ]
                , span [ class "compute" ] [ text " with " ]
                , span [] [ text "Pietro Grandi" ]
                ]
              , p []
                [ text
                    """
                    As the market started asking for more complex web-applications, the limits of a dynamic, loosely typed language like
                    Javascript forced the developers to look for solutions like Flow and Typescript. Elm is a functional language which
                    compiles to Javascript. It is strongly typed, has an ML syntax, and a small, yet skilled adn growing, community.
                    """
                ]
              , a [ class "linkedin" ] []
              , a [ class "website", href "http://pietrograndi.com" ] []
            ]
          , div [ class "row scheduleRow" ]
            [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
              [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
                [ span [] [ text "13:30" ]
                , span [] [ text "-" ]
                , span [] [ text "14:00" ]
                ]
              , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
                [ text "Food and networking" ]
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
                [ div [ class "cardFront", style [ ("background-image", "url(/images/speakers/pietro_grandi.jpg)") ] ] []
                , div [ class "cardBack" ]
                  [ h6 [] [ text "Pietro Grandi" ]
                  , p [ id "speakerPosition" ]
                    [ span []
                      [ text "Frontend Development at"
                      , a [ href "http://www.evokegaming.com/" ] [ span [] [ text " Evoke" ] ]
                      ]
                  , a [ class "linkedin", href "https://www.linkedin.com/in/pietrograndi" ] []
                  , a [ class "twitter", href "https://twitter.com/PietroGrandi3D" ] []
                  , p [ id "speakerDescription" ] [ text
                    """
                    Frontend Developer with a strong 3D Graphics background and a passion for languages.
                    Currently exploring the Functional Programming.
                    """ ]
                  ]
                ]
              ]
            , div [ class "speakerInfo" ]
              [ h6 [] [ text "Pietro Grandi" ]
              , p [] [ text "Frontend Developer at Evoke." ]
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
                , p [ class "email" ] [ text "tzuuc@yahoo.com" ]
                ]
              , div []
                [ span [ class "glyphicon glyphicon-earphone" ] []
                , p [ class "phone" ]
                  [ span [] [ text "+40" ]
                  , span [] [ text "744267230" ]
                  ]
                ]
              ]
            
            ]
          , div [ class "col-xs-12 col-sm-6 col-md-6 col-lg-6" ]
            [ div [ class "organizer" ]
                [ div [ class "name" ] [ text "Bogdan Dumitriu" ]
                , div [ class "position" ] [ text "Event Organizer" ]
                , div []
                  [ span [ class "glyphicon glyphicon-envelope" ] []
                  , p [ class "email" ] [ text "boggdan.dumitriu@gmail.com" ]
                  ]
                , div []
                  [ span [ class "glyphicon glyphicon-earphone" ] []
                  , p [ class "phone" ]
                    [ span [] [ text "+356" ]
                    , span [] [ text "99946933" ]
                    ]
                  ]
                ]
              ]
            ]
        ]
      , section [ id "location", class "row location" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
          [ h4 [] [ text "Location" ] ]
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
    ]


subscriptions : Model -> Sub Msg
subscriptions model =
    List.map (Platform.Sub.map StickyHeaderMsg) (StickyHeader.subscriptions Ports.scroll model.headerModel)
        |> Sub.batch
