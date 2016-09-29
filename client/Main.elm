import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, text, form, input, label, fieldset, img)

import Html.App as App
import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src)
import Http
import Task exposing (Task)
import Json.Decode exposing (list, string)
import String exposing (join, isEmpty)

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
            ( model, registerMe model )
        PostSucceed result ->
            ( { model | registered = True }, Cmd.none )
        PostFail error ->
            ( { model | error = "Sorry, there was an error." }, Cmd.none )


-- VIEW

view : Model -> Html Msg
view model =
    article [ class "container-fluid" ]
        [ header []
            [ headerView "" ]
        , section []
            [ h1 [][ text "Home and banner here"]
            , img [ src "malta.jpg" ] []
            ]
        , eventView
        , section []
            [ h1 [ id "registration" ] [ text "Registration"]
            , h2 [] [ text "MaltaJS event" ]
            , form [ id "signup-form", class "container-fluid" ]  
                [ fieldset [ class "row"] 
                    [ label [ for "name", class "col-md-4" ] [ text "Name: " ]
                    , input 
                        [ id "name"
                        , type' "text"
                        , class "col-md-4"
                        , value model.name
                        , onInput Name
                        ] []
                    ]
                , fieldset [ class "row"] 
                    [ label [ for "surname", class "col-md-4" ] [ text "Surname: " ]
                    , input 
                        [ id "surname"
                        , type' "text"
                        , class "col-md-4"
                        , value model.surname
                        , onInput Surname
                        ] []
                    ]
                , fieldset [ class "row"] 
                    [ label [ for "email", class "col-md-4" ] [ text "email: " ]
                    , input 
                        [ id "email"
                        , type' "email"
                        , class "col-md-4"
                        , value model.email
                        , onInput Email
                        ] []
                    ]
                ]
            , button [ onClick Register ] [ text "Sign Up!" ]
            ]
        , venueView
        , aboutView model.name
        ]

headerView : String -> Html a 
headerView selected = 
    ol [ class "breadcrumb" ]
    [ li [ class selected ] [ a [ href "#about" ] [ text "About" ] ]
    , li [] [ a [ href "#event" ] [ text "Event" ] ]
    , li [] [ a [ href "#registration" ] [ text "Registration" ] ]
    , li [] [ a [ href "#venue" ] [ text "Venue" ] ]
    ]


aboutView : String -> Html a
aboutView name =
    let
        default = "Bombastic community in Malta!"
        message =
            if isEmpty name then
                "We are waiting for you."
            else
                "We are waiting for you, " ++ name ++ "."
    in
        section []
                [ h1 [ id "about" ] [ text "MaltaJS"]
                , div []
                    [ p [] [ text ( join " " [ default, message ])]]
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
registerMe model =
    let
        url = "http://localhost:8001"
    in
        Task.perform PostFail PostSucceed (Http.post string url Http.empty) 