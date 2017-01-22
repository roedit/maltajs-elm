module Shared exposing (..)

import Form exposing (Model)
--import Scroll exposing (Move)
import Http exposing (Error)
import Html exposing (img)
import Html.Attributes exposing (src)
import StickyHeader

-- MODEL

type alias Model = 
  { registered : Bool
  , signed : Bool
  , error : String
  , formModel : Form.Model
  }

initialModel : Model
initialModel =
    { registered = False
    , signed = False
    , error = ""
    , formModel = Form.initialModel
    }


-- MESSAGE

type Msg
  = Register
  | PostResult (Result Error String)
  | FormMsg Form.Msg
