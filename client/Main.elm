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
import Widget

main = App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }


-- MODEL
type alias Model = 
  { registered : Bool
  , signed : Bool
  , error : String
  , widgetModel : Widget.Model
  }

initialModel : Model
initialModel =
  { registered = False
  , signed = False
  , error = ""
  , widgetModel = Widget.initialModel
  }

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


-- UPDATE
type Msg
  = Register
  | PostSucceed String
  | PostFail Http.Error
  | WidgetMsg Widget.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Register ->
      ( { model | signed = True }, registerMe model )
    PostSucceed result ->
      ( { model | registered = True }, Cmd.none )
    PostFail error ->
      ( { model | error = "Sorry, there was an error." }, Cmd.none )
    WidgetMsg subMsg ->
          let
              ( updatedWidgetModel, widgetCmd ) =
                  Widget.update subMsg model.widgetModel
          in
              ( { model | widgetModel = updatedWidgetModel }, Cmd.map WidgetMsg widgetCmd )


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
    , section []
      [ h1 [ id "event" ] [ text "Event description"]
      , eventView
      ]
    , section []
      [ h1 [ id "registration" ] [ text "Registration"]
      , h2 [] [ text "MaltaJS event" ]
      , App.map WidgetMsg (Widget.view model.widgetModel)
      , App.map WidgetMsg (Widget.alertView model.widgetModel)
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
    body = model.widgetModel
      |> Widget.formToJson
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