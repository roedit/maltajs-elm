module Shared exposing (..)

import Http exposing (Error)
import Html exposing (img)
import Html.Attributes exposing (src)
import Header
import Form


-- MODEL


type alias Model = 
  { showNavigation: Bool
  , formModel: Form.Model
  }

initialModel : Model
initialModel =
    { showNavigation = True
    , formModel = Form.initialModel
    }

