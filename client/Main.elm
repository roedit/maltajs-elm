import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, text, form, input, label, fieldset, img, span)

import Html.App as App
import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src, disabled)
import Http
import Task exposing (Task)
import Json.Decode exposing (list, string)
import String exposing (join, isEmpty)
import Regex
import Json.Encode
import Json.Decode 

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
  , company : String
  , email : String
  , registered : Bool
  , signed : Bool
  , error : String
  }

initialModel : Model
initialModel =
  { name = ""
  , surname = ""
  , company = ""
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
  | Company String
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
    Company company ->
      ( { model | company = company }, Cmd.none )
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
      [ label [ for "company", class "col-xs-4" ] [ text "Company: " ]
      , input 
        [ id "company"
        , type' "text"
        , class "col-xs-4"
        , value model.company
        , required True
        , onInput Company
        ] []
      ]
    , fieldset [ class "row"] 
      [ label [ for "email", class "col-xs-4" ] [ text "Email: " ]
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

alertView : Model -> Html a
alertView model =
  let
    classes =
      if (isFormInvalid model) then "alert alert-danger small" 
      else "hide"
  in
    div [ class classes ]
      [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
      , text "please fill in all the required fields" 
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
      , alertView model
      , button [ onClick Register ] [ text "Sign Up!" ]
      -- , button [ onClick Register, disabled (isFormInvalid model) ] [ text "Sign Up!" ]
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

isFormInvalid model = 
  let
    -- from http://emailregex.com/
    regex = """[-a-z0-9~!$%^&*_=+}{\\'?]+(\\.[-a-z0-9~!$%^&*_=+}{\\'?]+)*@([a-z0-9_][-a-z0-9_]*(\\.[-a-z0-9_]+)*
            \\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}
            \\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,5})?$"""
      |> Regex.regex
      |> Regex.caseInsensitive
  in
    (isEmpty model.name || isEmpty model.surname || isEmpty model.email) --|| not (Regex.contains regex model.email)

isFormValid model = not (isFormInvalid model)

-- todo: handle selected section
headerView : String -> Html a 
headerView selected = 
  ol [ class "breadcrumb" ]
  [ li [] [ a [ href "#about" ] [ text "About" ] ]
  , li [] [ a [ href "#event" ] [ text "Event" ] ]
  , li [] [ a [ href "#registration" ] [ text "Registration" ] ]
  , li [] [ a [ href "#venue" ] [ text "Venue" ] ]
  ]


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

decoder : Json.Decode.Decoder String 
decoder =
    Json.Decode.at [ "result" ]
       ( Json.Decode.string )

registerMe : Model -> Cmd Msg
registerMe model =
  let
    url = "http://localhost:3000/api/add-subscriber"
    body = 
      [ ("name", Json.Encode.string model.name)
      , ("surname", Json.Encode.string model.surname)
      , ("company", Json.Encode.string model.company)
      , ("email", Json.Encode.string model.email)
      ]
      |> Json.Encode.object
      |> Json.Encode.encode 0 
      |> Http.string
    request =
      { verb = "POST"
      , headers = [( "Content-Type", "application/json" )]
      , url = url
      , body = body 
      }
  in
    Task.perform PostFail PostSucceed (Http.fromJson decoder (Http.send Http.defaultSettings request))