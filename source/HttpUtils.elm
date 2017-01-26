module HttpUtils exposing (registerMe)

import Http
import Json.Decode exposing (list, string)
import Json.Encode
import Task

import Shared exposing (..)
import Form exposing (formToJson)

decoder : Json.Decode.Decoder String 
decoder =
    Json.Decode.at [ "subscriber" ]
       ( Json.Decode.string )


registerMe : Model -> Cmd Msg
registerMe model =
  let
    url = "/api/add-subscriber"
    body = model.formModel
      |> Form.formToJson
      |> Json.Encode.encode 0 
      |> Http.stringBody "application/json"
    post : Http.Request String
    post = Http.post url body decoder
  in
    Http.send PostResult post
