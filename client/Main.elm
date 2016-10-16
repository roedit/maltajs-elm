import Html exposing (Html, text, button, div, section, article, h1, p, a, header, ol, li, h2, h3, text, form, input, label, fieldset, img, span)

import Html.App as App
import Html.Events exposing (onClick, on, onInput)
import Html.Attributes exposing ( id, type', for, value, class, href, class, required, src, disabled, style)
import Platform.Sub
import String
import StickyHeader

import Content exposing (..)
import Ports exposing (..)
import Form
import Shared exposing (..)
import HttpUtils exposing (registerMe)


-- PROGRAM

main : Program Never
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
      let er = Debug.log "Post failed" (toString error) 
      in
      ( { model | error = er }, Cmd.none )
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
    div [ class "alert alert-danger small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
      , formErrorView
      ]
  else if not((String.isEmpty model.error)) then
    div [ class "alert alert-danger small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-exclamation-sign" ] []
      , p [] [ text "We apologize, something went wrong." ]
      , p [ class "hide" ] [ text model.error ]
      ]
  else if (model.registered) then
    div [ class "alert alert-success small" ]
    [ span [ class "glyphicon glyphicon-info-sign" ] []
    , p [] [ text "You're registered for the event!" ]  
    ]
  else
    div [ class "alert alert-info small col-xs-12 col-sm-9" ]
      [ span [ class "glyphicon glyphicon-info-sign" ] []
      , privacyView  
      ]
  
  
view : Model -> Html Msg
view model =
  let
    disableForm = (Form.isFormInvalid model.formModel) || model.registered
  in
    article []
      [ App.map StickyHeaderMsg (StickyHeader.view model.headerModel)
      , div [ class "container-fluid main" ]
        [ section [ class "row" ]
          [ img [ src "logo.jpg", class "logo" ] [] ]
        , section [ class "row" ]
          [ h1 [ id "event" ] [ text "Elm and functional programming"]
          , eventView
          ]
        , section [ class "row jumbotron" ]
          [ h1 [ id "registration" ] [ text "Save your seat!"]
          , h3 [] [ text "Saturday 29 October, 12.00" ]
          , App.map FormMsg (Form.view model.formModel)
          , div [ class "form-footer container-fluid" ]
            [ renderAlert model
            , button 
              [ onClick Register
              , class "btn btn-default col-xs-12 col-sm-9"
              , disabled disableForm
              ] [ text "Sign Up!" ]
            ]
          ]
        , section [ class "row" ]
          [ h1 [ id "venue" ] [ text "The venue"]
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
