module Shared exposing (..)

import Http exposing (Error)
import Html exposing (img)
import Html.Attributes exposing (src)
import Header


-- MODEL


type alias Model = 
  { showNavigation: Bool }

initialModel : Model
initialModel =
    { showNavigation = True }

