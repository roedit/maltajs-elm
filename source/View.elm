module View exposing (banner, footer, header, about)

import Html exposing (Html, div, img, h2, h3, h4, span, section,  text, p)
import Html.Attributes exposing (class, id, src)

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
    links =
        List.map 
            (\(title, url) -> Header.buildActiveItem title url [])
            [ ("Past events", "/") ]
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

