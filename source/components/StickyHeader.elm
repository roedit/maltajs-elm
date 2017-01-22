module StickyHeader exposing
    ( Item
    , Config
    , view
    , buildItem
    , buildActiveItem
    , buildLogo
    )

{-| This module provides a header components which accepts a brand and a list of links. It will react to window's scroll.

# Definition
@docs Model, Item, Port

# Helpers
@docs initialModel, msg, view, update, subscriptions, buildItem, buildActiveItem, buildLogo

-}

import Html
import Html exposing (div, header, text, h1, nav, a, img, span, ul, li, button)
import Html.Attributes exposing (href, class)
import Html.Events exposing (onClick)
import Time exposing (millisecond)
import String
import Random

{-| An header item has this type, and is returned by helper functions.
-}
type Item
    = Item
        { title : String
        , link : Maybe String
        , cssClasses : List String
        }

{-| The header's logo has this type, and it is returned by helper functions.
-}
type Logo msg
    = Logo
        { link : Maybe String
        , cssClasses : List String
        , image : Html.Html msg
        }

{-| Build a Item with a title and a list of css classes to be applied

    -- a header's item just showing the title
    headerBrand = StickyHeader.buildItem "" []
-}
buildItem : String -> List String -> Item
buildItem title cssClasses =
    Item { title = title, link = Nothing, cssClasses = cssClasses }

{-| Build a Item with a title and a list of css classes to be applied

    -- a header's item just showing the title
    headerBrand = StickyHeader.buildActiveItem "" "#home" []
-}
buildActiveItem : String -> String -> List String -> Item
buildActiveItem title url cssClasses =
    Item { title = title, link = Just url, cssClasses = cssClasses }

{-| Build a Logo item, givene the inner HTML that will be wrapper in a <span> element
    and places on the left of the title. It takes also a list of css classes to be applied.

    -- a simple logo with an image and the class 'logo' applied on it
    logoImage = 
        headerLogo = StickyHeader.buildLogo (img [ src "logo-elm.png" ] []) [ "logo" ]
-} 
buildLogo : (Html.Html msg) -> List String -> Logo msg
buildLogo image cssClasses =
    Logo
        { link = Nothing
        , cssClasses = cssClasses
        , image = image
        }

type alias Config msg =
    { logo : Maybe (Logo msg)
    , brand : Maybe Item 
    , links : List Item
    }

makeLink : Int -> Int -> Item -> Html.Html msg
makeLink activeIndex index component =
    let
        (Item record) = component
        { link, title, cssClasses } = record
        classesAsString = 
            (if index == activeIndex then "active" else "") :: cssClasses
            |> String.join " "
        --linkBuilder = \url -> li [] [ a [ href url, class classesAsString, onClick (Select index) ] [ text title ] ] 
        linkBuilder = \url -> li [] [ a [ href url, class classesAsString ] [ text title ] ] 
    in
        Maybe.map linkBuilder link
        |> Maybe.withDefault (a [ class classesAsString ] [ text title ])
        --|> Maybe.withDefault (a [ class classesAsString, onClick (Select index) ] [ text title ])

makeLogo : Logo msg -> Html.Html msg
makeLogo logo =
    let
        (Logo record) = logo
        { link, cssClasses, image } = record
    in
        span [ class (String.join " " cssClasses) ] [ image ]

view : Config msg -> Bool -> Maybe Int -> Html.Html msg
view config headerCollapsed active =
    let
        activeIndex = Maybe.withDefault (Random.minInt) active
        logo =
            Maybe.map (\l -> makeLogo l) config.logo
            |> Maybe.withDefault (Html.text "")
        brand = 
            Maybe.map (\b -> h1 [] [ (makeLink activeIndex -1 b) ]) config.brand
            |> Maybe.withDefault (Html.text "")
        navs = 
            List.indexedMap (makeLink activeIndex) config.links
        collapsedClasses =
            (if headerCollapsed then "collapse"
            else "collapse in") ++ " navbar-collapse"
    in
        header ([ class "col-xs-12 col-sm-12 col-md-12 menu" ] )
            [ nav [ class "navbar navbar-default" ]
              [ div [ class "container" ]
                [ div [ class "navbar-header" ]
                  [ a [ href "#home" ]
                    [ div [ class "logo" ] [] ]
                  --, button [ class "navbar-toggle", onClick ToggleNavbar ]
                  , button [ class "navbar-toggle" ]
                    [ span [ class "sr-only" ] []
                    , span [ class "icon-bar" ] []
                    , span [ class "icon-bar" ] []
                    , span [ class "icon-bar" ] []
                    ]
                  ]
                , div [ class collapsedClasses ]
                  [ ul [ class "nav navbar-nav navbar-right" ] navs ]
                ]
              ]
            ]