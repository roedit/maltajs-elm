module HttpUtils exposing (registerMe)

import Http
import Json.Decode exposing (list, string)
import Json.Encode
import Task

import Shared exposing (..)
import Form exposing (formToJson)

decoder : Json.Decode.Decoder String 
decoder =
    Json.Decode.at [ "result" ]
       ( Json.Decode.string )

registerMe : Model -> Cmd Msg
registerMe model =
  let
    -- url = "http://localhost:3000/api/add-subscriberu"
    url = "http://localhost:3000/api/add-subscriber"
    body = model.formModel
      |> Form.formToJson
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