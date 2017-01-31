module View exposing (banner, contacts, footer, header, about, eventDescription)

import Html exposing (Html, a, div, img, hr, h2, h3, h4, h5, span, section,  text, p)
import Html.Attributes exposing (class, id, src, href, style, attribute)

import Shared exposing (Model)
import Content exposing (..)
import Header

twelveColumns = "col-xs-12 col-sm-12 col-md-12 col-lg-12"


banner : Html msg
banner =
  section [ id "home", class "row banner" ]
    [ h2 [] [ text "Malta JS" ]
      , h3 [] [ text "Javascript community in Malta" ]
      , p [] [ text "Talks, meetups, coding sessions, ..." ]
    ]


footer : Html msg
footer = 
  Html.footer [ class "footer" ]
    [ div [ class twelveColumns ]
      [ div [ class "leftSide" ]
        [ p [] [ text "Copyright Ⓒ MaltaJs 2017 All Rights Reserved" ] ]
      , div [ class "rightSide" ] []
      ]
    ]


header : Bool -> Maybe Int -> (Bool -> msg) -> Html msg
header headerCollapsed active onNavigation  =
  let
    brand = Header.buildItem "MaltaJS" [ "brand" ]
    logo =
      Header.buildLogo
        (img [ src "images/logo.jpg" ] []) [ "header-logo" ]
    links = []
      {--
        List.map 
            (\(title, url) -> Header.buildActiveItem title url [])
            [ ("Past events", "/") ]
            --}
    config : Header.Config msg
    config = Header.Config (Just logo) (Just brand) links (Just onNavigation)
  in
    Header.view config headerCollapsed active


about : Model -> Html msg
about model =
  section [ id "about", class "row about" ]
    [ div [ class twelveColumns ]
      [ h4 [] [ text "About" ] ]
    , div [ class twelveColumns ]
      [ Content.aboutView ]
    ]

type alias Schedule msg =
  { start: String
  , end: String
  , content: Maybe (Html msg)
  , title: Maybe String
  }


contacts : Html msg
contacts =
  section [ class "row contact", id "contact" ]
  [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
      [ h4 []
        [ text "Contact" ]
      ]
    , div [ class "col-xs-12 col-sm-6 col-md-6 col-lg-6" ]
      [ div [ class "organizer" ]
        [ div [ class "name" ]
          [ text "Andrei Toma" ]
        , div [ class "position" ]
          [ text "Event Organizer" ]
        , div []
          [ span [ class "glyphicon glyphicon-envelope" ]
            []
          , p [ class "email" ]
            [ text "mail@andreitoma.com" ]
          ]
        , div []
          [ span [ class "glyphicon glyphicon-earphone" ]
            []
          , p [ class "phone" ]
            [ span []
              [ text "+40" ]
            , span []
              [ text "744267230" ]
            ]
          ]
        ]
      ]
    , div [ class "col-xs-12 col-sm-6 col-md-6 col-lg-6" ]
      [ div [ class "organizer" ]
        [ div [ class "name" ]
          [ text "Bogdan Dumitriu" ]
        , div [ class "position" ]
          [ text "Event Organizer" ]
        , div []
          [ span [ class "glyphicon glyphicon-envelope" ]
            []
          , p [ class "email" ]
            [ text "boggdan.dumitriu@gmail.com" ]
          ]
        , div []
          [ span [ class "glyphicon glyphicon-earphone" ]
            []
          , p [ class "phone" ]
            [ span []
              [ text "+356" ]
            , span []
              [ text "99946933" ]
            ]
          ]
        ]
      ]
    ]
  ]

--eventDescription : Html msg
eventDescription =
  section [ class "row schedule", id "schedule" ]

    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
      [ h4 []
        [ text "Schedule" ]
      ]

    , div []
      [ div [ class "row scheduleRow" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
          [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
            [ span []
              [ text "12:00" ]
            , span []
              [ text "-" ]
            , span []
              [ text "12:15" ]
            ]
          , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
            [ text "WELCOME COFFEE & REGISTRATION" ]
          ]
        ]

      , div [ class "row scheduleRow" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
          [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
            [ span []
              [ text "12:15" ]
            , span []
              [ text "-" ]
            , span []
              [ text "12:30" ]
            ]
          , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
            [ text "Welcome speech" ]
          ]
        ]

      , div [ class "row scheduleRow" ]
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle" ]
          [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
            [ span []
              [ text "12:30" ]
            , span []
              [ text "-" ]
            , span []
              [ text "13:30" ]
            ]
          , div [ class "col-xs-8 col-sm-10 col-md-10 col-lg-10 eventLine" ]
            [ hr []
              []
            ]
          ]
        , div [ class "col-xs-12 col-sm-9 col-md-9 col-lg-9 col-sm-offset-3 col-md-offset-3 col-lg-offset-3 eventSpeaker" ]
          [ div
            [ class "speakerImg", attribute "style" "background-image: url(\"/images/speakers/pietro_grandi.jpg\");" ]
            []
          , h5 []
            [ span []
              [ text "Elm: frontend code without runtime exceptions" ]
            , span [ class "compute" ]
              [ text "with " ]
            , span []
              [ text "Pietro Grandi" ]
            ]
          , p []
            [ text "As the market started asking for more complex web-applications, the limits of a dynamic, loosely typed language like                    Javascript forced the developers to look for solutions like Flow and Typescript. Elm is a functional language which                    compiles to Javascript. It is strongly typed, has an ML syntax, and a small, yet skilled and growing, community.                    " ]
          , a [ class "linkedin" ]
            []
          , a [ class "website", href "http://pietrograndi.com" ]
            []
          ]

        , div [ class "row scheduleRow" ]
          [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
            [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
              [ span []
                [ text "13:30" ]
              , span []
                [ text "-" ]
              , span []
                [ text "14:00" ]
              ]
            , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
              [ text "Networking" ]
            ]
          ]
        ]
      ]
    ]
