import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, text, form, input, label)

import Html.App as App
import Html.Events exposing (onClick, on)
import Html.Attributes exposing ( id, type', for, value, class, href, class)
import Http
import Task exposing (Task)
import Json.Decode exposing (list, string)

main = App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL
type alias Model = 
    { name : String
    , surname : String
    , registered : Bool
    , signed : Bool
    , error : String
    }

initialModel : Model
initialModel =
    { name = ""
    , surname = ""
    , registered = False
    , signed = False
    , error = ""
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


-- UPDATE
type Msg
    = Name String
    | Surname String
    | Register
    | PostSucceed String
    | PostFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Name name ->
            ( { model | name = name }, Cmd.none )
        Surname surname ->
            ( { model | surname = surname }, Cmd.none )
        Register ->
            ( model, registerMe model )
        PostSucceed result ->
            ( { model | registered = True }, Cmd.none )
        PostFail error ->
            ( { model | error = "Sorry, there was an error." }, Cmd.none )


-- VIEW

view : Model -> Html Msg
view model =
    article []
        [ header []
            [ headerView "" ]
        , section [] [ h1 [][ text "Home and banner here"] ]
        , eventView
        , section []
            [ h1 [ id "registration" ] [ text "Registration"]
            , h2 [] [ text "MaltaJS event" ]
            , form [ id "signup-form" ] 
                [ label [ for "name" ] [ text "Name: " ]
                , input [ id "name", type' "text", value model.name ] []
                , label [ for "surname" ] [ text "Surname: " ]
                , input [ id "surname", type' "text", value model.surname ] []
                ]
            , button [ onClick Register ] [ text "Sign Up!" ]
            ]
        , venueView
        , aboutView
        ]

headerView : String -> Html a 
headerView selected = 
    ol [ class "breadcrumb" ]
    [ li [ class selected ] [ a [ href "#about" ] [ text "About" ] ]
    , li [] [ a [ href "#event" ] [ text "Event" ] ]
    , li [] [ a [ href "#registration" ] [ text "Registration" ] ]
    , li [] [ a [ href "#venue" ] [ text "Venue" ] ]
    ]


aboutView : Html a
aboutView =
    section []
            [ h1 [ id "about" ] [ text "MaltaJS"]
            , div []
                [ p [] [ text "Bombastic community in Malta!"]]
            ]

venueView : Html a
venueView = 
    section []
            [ h1 [ id "venue" ] [ text "Venue"]
            , div []
                [ p [] [ text "Super cool Microsoft's Office :-)"]]
            ]

eventView : Html a
eventView = section []
            [ h1 [ id "event" ] [ text "Event description"]
            , div []
                [ p [] [ text "Fantastic event in Malta, hosted by MaltaJS: will speak about Elm."]]
            ]

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


registerMe : Model -> Cmd Msg
registerMe data =
    let
        url = "http://localhost:8001"
    in
        Task.perform PostFail PostSucceed (Http.post string url Http.empty) 