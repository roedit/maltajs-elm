module Shared exposing (..)

import Form exposing (Model)
import Scroll exposing (Move)
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
  , headerModel : StickyHeader.Model
  }

headerLinks =
    List.map 
        (\(title, url) -> StickyHeader.buildActiveItem title url [])
        [ ("Subscribe", "#subscribe")
        , ("Schedule", "#schedule")
        , ("Speakers", "#speakers")
        , ("Location", "#location")
        , ("Contacts", "#contacts")
        ]

initialModel : Model
initialModel =
  let
    headerBrand = StickyHeader.buildItem "MaltaJS" [ "brand" ]
    headerLogo =
      StickyHeader.buildLogo
        (img [ src "images/logo.jpg" ] []) [ "header-logo" ]
    headerInitialModel =
      StickyHeader.initialModel (Just headerLogo) (Just headerBrand) headerLinks
  in
    { registered = False
    , signed = False
    , error = ""
    , formModel = Form.initialModel
    , headerModel = headerInitialModel
    }


-- MESSAGE

type Msg
  = Register
  | PostSucceed String
  | PostFail Error
  | FormMsg Form.Msg
  | StickyHeaderMsg StickyHeader.Msg
