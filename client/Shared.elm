module Shared exposing (..)

import Widget exposing (Model)
import Scroll exposing (Move)
import Http exposing (Error)


-- MODEL

type alias Model = 
  { registered : Bool
  , signed : Bool
  , error : String
  , widgetModel : Widget.Model
  , scrollTop: Float 
  }

initialModel : Model
initialModel =
  { registered = False
  , signed = False
  , error = ""
  , widgetModel = Widget.initialModel
  , scrollTop = 0.0 
  }


-- MESSAGE

type Msg
  = Register
  | PostSucceed String
  | PostFail Error
  | WidgetMsg Widget.Msg
  | Scrolling Move 