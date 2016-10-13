import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, text, form, input, label, fieldset, img, span)

import Html.App as App
import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src, disabled, style)
import Platform.Sub
import Scroll exposing (Move)
import String
import StickyHeader

import Content exposing (..)
import Ports exposing (..)
import Form
import Shared exposing (..)
import HttpUtils exposing (registerMe)


-- PROGRAM

main = App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Register ->
      ( { model | signed = True }, registerMe model )
    PostSucceed result ->
        ( { model | registered = True }, Cmd.none )
    PostFail error ->
      ( { model | error = "Sorry, there was an error." }, Cmd.none )
    FormMsg subMsg ->
      let
        ( updatedFormModel, widgetCmd ) =
          Form.update subMsg model.formModel
      in
        ( { model | formModel = updatedFormModel }, Cmd.map FormMsg widgetCmd )
    StickyHeaderMsg subMsg->
        let
            ( updatedHeaderModel, headerCmd ) =
                StickyHeader.update subMsg model.headerModel
        in
            ( { model | headerModel = updatedHeaderModel }
            , Cmd.map StickyHeaderMsg headerCmd
            )

    
-- VIEW

renderAlert : Model -> Html Msg
renderAlert model =
  if (Form.isFormInvalid model.formModel) then
    div [ class "alert alert-danger small" ]
      [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
      , p [ class "text-danger form-error-message" ] [ text "please fill in all the required fields" ]  
      ]
  else
    privacyView
  
  
view : Model -> Html Msg
view model =
  let
    success =
      if model.registered then App.map FormMsg (Form.submittedView model.formModel)
      else  Html.text ""
  in
  article []
    [ App.map StickyHeaderMsg (StickyHeader.view model.headerModel)
    , div [ class "container-fluid main" ]
      [ section [ class "row" ]
        [ img [ src "logo.jpg", class "logo" ] [] ]
      , section [ class "row" ]
        [ h1 [ id "event" ] [ text "Event description"]
        , eventView
        ]
      , section [ class "row" ]
        [ h1 [ id "registration" ] [ text "Registration"]
        , h2 [] [ text "MaltaJS event" ]
        , App.map FormMsg (Form.view model.formModel)
        , div [ class "form-footer" ]
          [ renderAlert model
          , (if (String.isEmpty model.error) then Html.text "" else (p [] [ text model.error ]))
          , success
          , button 
            [ onClick Register
            , class "btn btn-default"
            , disabled (Form.isFormInvalid model.formModel)
            ] [ text "Sign Up!" ]
          ]
        ]
      , section [ class "row" ]
        [ h1 [ id "venue" ] [ text "Venue"]
        , venueView
        ]
      , section [ class "row" ]
        [ h1 [ id "about" ] [ text "MaltaJS"]
        , aboutView
        ]
      ]
    ]


subscriptions : Model -> Sub Msg
subscriptions model =
    List.map (Platform.Sub.map StickyHeaderMsg) (StickyHeader.subscriptions Ports.scroll model.headerModel)
        |> Sub.batch