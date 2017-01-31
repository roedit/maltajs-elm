module View exposing (banner, footer, header, about, event)

import Html exposing (Html, a, div, img, h2, h3, h4, h5, span, section,  text, p)
import Html.Attributes exposing (class, id, src, href, style)

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

scheduleRow : Schedule msg -> Html msg
scheduleRow schedule =
  let
    (eventClass, content) =
      case (schedule.content, schedule.title) of
        (Just(children), Nothing) ->
          ("eventLine", children)
        (Nothing, Just(string)) ->
          ("eventBackground", div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ] [ text string ])
        _ -> ("", text "")
  in
    div [ class "row scheduleRow" ]
      [ div [ class ("col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle " ++ eventClass) ] --eventBackground" ]
        [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
          [ span [] [ text schedule.start ]
          , span [] [ text "-" ]
          , span [] [ text schedule.end ]
          ]
        ,  content
        ]
      , content
      ]

event : Model -> Html msg
event model =
  let
    eventDescription =
      div [ class "col-xs-12 col-sm-9 col-md-9 col-lg-9 col-sm-offset-3 col-md-offset-3 col-lg-offset-3 eventSpeaker" ]
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
  in
  section [ id "schedule", class "row schedule" ]
    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
      [ h4 [] [ text "Schedule" ] ]
    , div []
      [ scheduleRow (Schedule "19.00" "19.15" Nothing (Just "Registration"))
      , scheduleRow (Schedule "19.15" "19.30" Nothing (Just "Welcome speech"))
      , scheduleRow (Schedule "19.30" "20.00" (Just eventDescription) Nothing)
      {--
            , div [ class "row scheduleRow" ]
              [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
                [ div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
                  [ span [] [ text "13:30" ]
                  , span [] [ text "-" ]
                  , span [] [ text "14:00" ]
                  ]
                , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
                  [ text "Networking" ]
                ]
              ]
              --}
      ]
    ]

