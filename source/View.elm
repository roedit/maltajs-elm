module View exposing
  ( Coordinates
  , about
  , banner
  , contacts
  , eventDescription
  , footer
  , header
  , map
  , registrationForm
  , sponsor
  )

import Html exposing (Html, a, button, div, img, hr, h2, h3, h1, h5, h6, span, section, text, p)
import Html.Attributes exposing (class, disabled, id, src, href, style, attribute)
import Html.Events exposing (onClick)
import Json.Encode as JSE

import Shared exposing (..)
import Content exposing (..)
import Header
import Form

twelveColumns = "col-xs-12 col-sm-12 col-md-12 col-lg-12"
sixColumns = "col-xs-12 col-sm-10 col-md-6 col-lg-4"

banner : Html msg
banner =
  section [ id "home", class "row banner" ]
    [ h2 [] [ text "Malta JS" ]
      , h3 [] [ text "Javascript community in Malta" ]
      , p [] [ text "23rd of FEBRUARY | Royal Malta Yacht Club" ]
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


sponsor : Html msg -> Html msg
sponsor content =
  section [ id "sponsor", class "row sponsor" ]
    [ div [ class twelveColumns ]
      [ h1 [] [ text "Thanks to..." ] ]
    , div [ class sixColumns ]
      [ a [ href "https://igamingcloud.com/" ] [ img [ src sponsorLogo ] [] ] ]
    , div [ class twelveColumns ]
      [ content ]
    ]

about : Html msg -> Html msg
about content =
  section [ id "about", class "row about" ]
    [ div [ class twelveColumns ]
      [ h1 [] [ text "About" ] ]
    , div [ class twelveColumns ]
      [ content ]
    ]

viewOrganizer : Organizer -> Html msg
viewOrganizer organizer =
  div [ class "col-xs-12 col-sm-6 col-md-6 col-lg-6" ]
    [ div [ class "organizer" ]
      [ div [ class "name" ]
        [ text organizer.name ]
      , div [ class "position" ]
        [ text "Event Organizer" ]
      , div []
        [ span [ class "glyphicon glyphicon-envelope" ]
          []
        , p [ class "email" ]
          [ text organizer.email ]
        ]
      ]
    ]

renderSchedule : Schedule -> Html msg
renderSchedule schedule =
  div [ class "row scheduleRow" ]
    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle eventBackground" ]
      [ timeSpan schedule.start schedule.end
      , div [ class "col-xs-8 col-sm-8 col-md-8 col-lg-8 textCenter" ]
        [ text schedule.title ]
      ]
    ]

contacts : List Organizer -> Html msg
contacts organizers =
  section [ class "row contact", id "contact" ]
    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12" ]
      (
        [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
          [ h1 []
            [ text "Contact" ]
          ]
        ] ++ (List.map viewOrganizer organizers)
      )
    ]

timeSpan : String -> String -> Html msg
timeSpan start end =
  div [ class "col-xs-4 col-sm-2 col-md-2 col-lg-2 eventTimeHolder" ]
    [ span []
      [ text start ]
    , span []
      [ text "-" ]
    , span []
      [ text end ]
    ]


renderExtendedSchedule : ExtendedSchedule -> Html msg
renderExtendedSchedule schedule =
  div [ class "row scheduleRow" ]
    [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 eventTitle" ]
      [ timeSpan schedule.start schedule.end
      , div [ class "col-xs-8 col-sm-10 col-md-10 col-lg-10 eventLine" ]
        [ hr [] [] ]
      ]
    , div [ class "col-xs-12 col-sm-9 col-md-9 col-lg-9 col-sm-offset-3 col-md-offset-3 col-lg-offset-3 eventSpeaker" ]
      (
        [ div
        -- speaker's image
          [ class "speakerImg", attribute "style" "background-image: url(\"/images/speakers/peter-bakonyi.png\");" ]
          []
        , h5 []
          [ span []
            [ text schedule.title ]
          , span [ class "compute" ]
            [ text " with " ]
          , span []
            [ text schedule.name ]
          ]
        , p []
          [ text schedule.description ]
        ] ++ (List.map (\(c, l) -> a [ class c, href l ] []) schedule.links)
      )
    ]



eventDescription : List Schedule -> List ExtendedSchedule -> List Schedule -> Html msg
eventDescription pre main post =
  let
    prepend = List.map renderSchedule pre
    central = List.map renderExtendedSchedule main
    append = List.map renderSchedule post
  in
    section [ class "row schedule", id "schedule" ]

      [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
        [ h1 []
          [ text "Schedule" ]
        ]

      , div [] (prepend ++ central ++ append)
      ]

type alias Coordinates =
  { initialZoom : Int
  , latitude : Float
  , longitude : Float
  }

map : Coordinates -> Html msg
map coordinates =
  let
    json =
      JSE.object
        [ ("initialZoom", JSE.int coordinates.initialZoom)
        , ("mapCenterLat", JSE.float coordinates.latitude)
        , ("mapCenterLng", JSE.float coordinates.longitude)
        ]
  in
    section [ id "location", class "row location" ]
      [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
        [ h1 [] [ text "Location" ] ]
      , div
        [ id "map"
        , class "map-gic"
        , attribute "data-coordinates" (JSE.encode 0 json) ] []
      ]

alert : Model -> Html Msg
alert model =
  if (Form.isFormInvalid model.formModel) then
    div [ class "alert alert-danger small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
      , formErrorView
      ]
  else if not((String.isEmpty model.error)) then
    div [ class "alert alert-danger small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
      , p [] [ text model.error ]
      , p [ class "hide" ] [ text model.error ]
      ]
  else if (model.registered) then
    div [ class "alert alert-success small" ]
      [ span [ class "glyphicon glyphicon-info-sign" ] []
      , p [] [ text "You're registered for the event!" ]  
      ]
  else
    Html.text ""

registrationForm : Model -> Html Msg
registrationForm model =
  let
    disableForm = False && (Form.isFormInvalid model.formModel) || model.registered
  in
    section [ id "subscribe", class "row subscribe" ]
      [ div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter" ]
        [ h1 [] [ text "Subscribe" ], h6 [] [ text "Only 30 seats available." ] ]
      , mapMsgToForm model
      , div [ class "col-xs-12 col-sm-12 col-md-12 col-lg-12 textCenter form-footer" ]
        [ alert model
        , button 
          [ onClick Register
          , class "btn btn-default register"
          , disabled disableForm
          ] [ text "Subscribe" ]
        ]
    ]

