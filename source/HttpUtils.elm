module HttpUtils exposing (registerMe, errorExtractor)

import Http exposing (..)
import Json.Decode exposing (decodeString, list, string)
import Json.Encode
import Task

import Shared exposing (..)
import Form exposing (formToJson)

decoder : Json.Decode.Decoder String 
decoder =
    Json.Decode.at [ "subscriber" ]
       ( Json.Decode.string )

errorDecoder : Json.Decode.Decoder String 
errorDecoder =
    Json.Decode.at [ "error" ]
       ( Json.Decode.string )


errorExtractor : Error -> String
errorExtractor error =
  case error of
    BadStatus response ->
      Result.withDefault "Unknown error" (decodeString errorDecoder response.body)
    _ -> "We apologize, something went wrong."


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
