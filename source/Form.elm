module Form exposing (..)

import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, text, form, input, label, fieldset, img, span)

import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src, disabled, placeholder )
import String exposing (join, isEmpty)
import Regex
import Json.Encode


-- MODEL
type alias Model = 
  { name : String
  , surname : String
  , company : String
  , email : String
  , error : String
  }

initialModel : Model
initialModel =
  { name = ""
  , surname = ""
  , company = ""
  , email = ""
  , error = ""
  }



-- MESSAGES


type Msg
  = Name String
  | Surname String
  | Company String
  | Email String



-- VIEW

formFieldClasses = "col-xs-12 col-sm-6 col-md-3 col-lg-3"

view : Model -> Html Msg
view model =
    form [ id "signup-form", class "container-fluid" ]
      [ div [ class "row" ]
        [ div [ class formFieldClasses ]
          [ input 
            [ id "name"
            , type' "text"
            , placeholder "Name"
            , value model.name
            , required True
            , onInput Name
            ] []
          ]
        , div [ class formFieldClasses ]
          [ input 
            [ id "surname"
            , type' "text"
            , placeholder "Surname"
            , value model.surname
            , required True
            , onInput Surname
            ] []
          ]
        , div [ class "clearfix visible-xs-block" ] []
        , div [ class formFieldClasses ]
          [ input 
            [ id "company"
            , type' "text"
            , placeholder "Company"
            , value model.company
            , required True
            , onInput Company
            ] []
          ]
        , div [ class formFieldClasses ]
          [ input 
            [ id "email"
            , type' "email"
            , placeholder "Email"
            , value model.email
            , required True
            , onInput Email
            ] []
          ]
        ]
      ]


-- UTILS

isFormInvalid model = 
  let
    -- from http://emailregex.com/
    regex = "^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]{1,6})+$"
      |> Regex.regex
      |> Regex.caseInsensitive
    isMailOk = Regex.contains regex model.email
  in
    (isEmpty model.name || isEmpty model.surname || isEmpty model.email) || not isMailOk

isFormValid model = not (isFormInvalid model)

formToJson : Model -> Json.Encode.Value
formToJson model = 
  Json.Encode.object 
    [ ("name", Json.Encode.string model.name)
    , ("surname", Json.Encode.string model.surname)
    , ("company", Json.Encode.string model.company)
    , ("email", Json.Encode.string model.email)
    ]

-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
  case message of
    Name name ->
      ( { model | name = name }, Cmd.none )
    Surname surname ->
      ( { model | surname = surname }, Cmd.none )
    Company company ->
      ( { model | company = company }, Cmd.none )
    Email email ->
      ( { model | email = email }, Cmd.none )
