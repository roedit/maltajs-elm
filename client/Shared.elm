module Shared exposing (..)

import Form exposing (Model)
import Scroll exposing (Move)
import Http exposing (Error)
import StickyHeader

-- MODEL

type alias Model = 
  { registered : Bool
  , signed : Bool
  , error : String
  , formModel : Form.Model
  , headerModel : StickyHeader.Model
  }

headerLinks =
    List.map 
        (\(title, url) -> StickyHeader.buildActiveItem title url [])
        [ ("About", "#about")
        , ("Event", "#event")
        , ("Registration", "#registration")
        , ("Venue", "#venue")
        ]

initialModel : Model
initialModel =
  let
    headerBrand = StickyHeader.buildItem "MaltaJS" [ "brand" ]
  in
    { registered = False
    , signed = False
    , error = ""
    , formModel = Form.initialModel
    , headerModel = StickyHeader.initialModel (Just headerBrand) headerLinks
    }


-- MESSAGE

type Msg
  = Register
  | PostSucceed String
  | PostFail Error
  | FormMsg Form.Msg
  | StickyHeaderMsg StickyHeader.Msg