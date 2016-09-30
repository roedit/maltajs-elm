import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, text, form, input, label, fieldset, img)

import Html.App as App
import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src, disabled)
import Http
import Task exposing (Task)
import Json.Decode exposing (list, string)
import String exposing (join, isEmpty)

import Content exposing (..)

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
    , email : String
    , registered : Bool
    , signed : Bool
    , error : String
    }

initialModel : Model
initialModel =
    { name = ""
    , surname = ""
    , email = ""
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
    | Email String
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
        Email email ->
            ( { model | email = email }, Cmd.none )
        Register ->
            ( { model | signed = True }, registerMe model )
        PostSucceed result ->
            ( { model | registered = True }, Cmd.none )
        PostFail error ->
            ( { model | error = "Sorry, there was an error." }, Cmd.none )


-- VIEW

formView : Model -> Html Msg
formView model =
    form [ id "signup-form", class "container-fluid" ]  
                [ fieldset [ class "row"] 
                    [ label [ for "name", class "col-xs-4" ] [ text "Name: " ]
                    , input 
                        [ id "name"
                        , type' "text"
                        , class "col-xs-4"
                        , value model.name
                        , required True
                        , onInput Name
                        ] []
                    ]
                , fieldset [ class "row"] 
                    [ label [ for "surname", class "col-xs-4" ] [ text "Surname: " ]
                    , input 
                        [ id "surname"
                        , type' "text"
                        , class "col-xs-4"
                        , value model.surname
                        , required True
                        , onInput Surname
                        ] []
                    ]
                , fieldset [ class "row"] 
                    [ label [ for "email", class "col-xs-4" ] [ text "email: " ]
                    , input 
                        [ id "email"
                        , type' "email"
                        , class "col-xs-4"
                        , value model.email
                        , required True
                        , onInput Email
                        ] []
                    ]
                ]

view : Model -> Html Msg
view model =
    article [ class "container-fluid" ]
        [ header []
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
            , formView model
            , button [ onClick Register, disabled (isFormInvalid model) ] [ text "Sign Up!" ]
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

isFormInvalid model = isEmpty model.name || isEmpty model.surname || isEmpty model.email
isFormValid model = not (isFormInvalid model)

headerView : String -> Html a 
headerView selected = 
    ol [ class "breadcrumb" ]
    [ li [ class selected ] [ a [ href "#about" ] [ text "About" ] ]
    , li [] [ a [ href "#event" ] [ text "Event" ] ]
    , li [] [ a [ href "#registration" ] [ text "Registration" ] ]
    , li [] [ a [ href "#venue" ] [ text "Venue" ] ]
    ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


registerMe : Model -> Cmd Msg
registerMe model =
    let
        url = "http://localhost:8001"
    in
        Task.perform PostFail PostSucceed (Http.post string url Http.empty) 