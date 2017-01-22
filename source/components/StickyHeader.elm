module StickyHeader exposing
    ( Item
    , Model
    , Port
    , initialModel
    , Msg
    , view
    , update
    , subscriptions
    , buildItem
    , buildActiveItem
    , buildLogo
    )

{-| This module provides a header components which accepts a brand and a list of links. It will react to window's scroll.

# Definition
@docs Model, Item, Port

# Helpers
@docs initialModel, Msg, view, update, subscriptions, buildItem, buildActiveItem, buildLogo

-}

import Html
import Html exposing (div, header, text, h1, nav, a, img, span, ul, li, button)
import Html.Attributes exposing (href, class)
import Html.Events exposing (onClick)
--import Animation exposing (px)
--import Animation
--import Scroll exposing (Move)
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
type Logo
    = Logo
        { link : Maybe String
        , cssClasses : List String
        , image : Html.Html Msg
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
buildLogo : (Html.Html Msg) -> List String -> Logo
buildLogo image cssClasses =
    Logo
        { link = Nothing
        , cssClasses = cssClasses
        , image = image
        }

{-| Represent the header's model: attach it to your model

    -- inserting header's model in your application model
    type alias Model =
        { headerModel: StickyHeader.Model }
-}
type alias Model =
    --{ style : Animation.State
    { current : Float
    , nextGoal : Float
    , logo : Maybe Logo
    , brand : Maybe Item
    , links : List Item
    , speedUp : Int
    , speedDown : Int
    , active : Maybe Int
    , headerCollapsed : Bool
    }

{-| Helper function to initialize the header's model. It accepts an optional brand and a list of links.

    -- initializing your model
    initialModel =
        let
            headerBrand = StickyHeader.Item "" (Just "#home") []
        in
            { headerModel = StickyHeader.initialModel (Just headerBrand) [] }
-}
initialModel : Maybe Logo -> Maybe Item -> List Item -> Model
initialModel logo brand links =
    --{ style = Animation.style [ Animation.top (px 0) ]
    { current = 0.0
    , nextGoal = 0.0
    , logo = logo
    , brand = brand
    , links = links
    , speedUp = 50
    , speedDown = 500
    , active = Nothing
    , headerCollapsed = True
    }

{-| The messages being used for scroll events and header's movement. Are to be put in union with your message type.

    -- extend your own messages
    type Msg
        = StickyHeaderMsg StickyHeader.Msg
        | -- your messages

-}
type Msg
    --=Header Move
    --| Animate Animation.Msg
    = Select Int
    | ToggleNavbar

init =
    ( initialModel, Cmd.none )
{--
easing speed =
    Animation.easing
        { duration = toFloat(speed) * millisecond
        , ease = (\x -> x^2)
        }--}

animateScroll : Model -> (Model, Cmd a)
animateScroll model =
    let
        start = model.current
        end = model.nextGoal
        speed =
            if (start > end) then model.speedUp
            else model.speedDown
        {--style = 
            Animation.queue [ Animation.toWith (easing speed) [ Animation.top (px end ) ] ]
                <| Animation.style [ Animation.top (px start) ] --}
        newModel = model --{ model | style = style }
    in
        --(newModel, Cmd.none)
        (model, Cmd.none)
{--
onGrow model =
    Scroll.onUp animateScroll

onShrink model =
    Scroll.onDown (\m -> (m, Cmd.none))
--}


{-| Update function to handle the header's messages. It needs to be placed inside your application's update function.

    -- handling header's messages in your application with update function
    update msg model =
        case msg of
            StickyHeaderMsg subMsg->
                let
                    ( updatedModel, headerCmd ) = StickyHeader.update subMsg model.headerModel
                in
                    ( { model | headerModel = updatedModel }, Cmd.map StickyHeaderMsg headerCmd )
-}
update : Msg -> Model -> (Model, Cmd a)
update action model =
    case action of
    {--
        Animate animMsg ->
            let
                newModel = 
                    { model
                    | style = Animation.update animMsg model.style
                    , current = model.nextGoal 
                    }
            in
                (newModel, Cmd.none)
                --}
        --Header move ->
         --   (model, Cmd.none)
            {--
            let
                (previous, current) = move
                newModel = { model | nextGoal = current } 
            in
                Scroll.handle [ onGrow model, onShrink model ] move newModel
                --}
        Select index ->
            ({ model | active = Just index }, Cmd.none)
        ToggleNavbar ->
            let
                newModel =
                    { model | headerCollapsed = not model.headerCollapsed }
            in
                (newModel, Cmd.none)

makeLink : Int -> Int -> Item -> Html.Html Msg
makeLink activeIndex index component =
    let
        (Item record) = component
        { link, title, cssClasses } = record
        classesAsString = 
            (if index == activeIndex then "active" else "") :: cssClasses
            |> String.join " "
        linkBuilder = \url -> li [] [ a [ href url, class classesAsString, onClick (Select index) ] [ text title ] ] 
    in
        Maybe.map linkBuilder link
        |> Maybe.withDefault (a [ class classesAsString, onClick (Select index) ] [ text title ])

makeLogo : Logo -> Html.Html Msg
makeLogo logo =
    let
        (Logo record) = logo
        { link, cssClasses, image } = record
    in
        span [ class (String.join " " cssClasses) ] [ image ]

{-| Provides the Html, given an updated model.
    
    -- insert it in your view function
    view model =
        App.map StickyHeaderMsg (StickyHeader.view model.headerModel)

-}
view : Model -> Html.Html Msg
view model =
    let
        --styles = Animation.render model.style
        activeIndex = Maybe.withDefault (Random.minInt) model.active
        logo =
            Maybe.map (\l -> makeLogo l) model.logo
            |> Maybe.withDefault (Html.text "")
        brand = 
            Maybe.map (\b -> h1 [] [ (makeLink activeIndex -1 b) ]) model.brand
            |> Maybe.withDefault (Html.text "")
        navs = 
            List.indexedMap (makeLink activeIndex) model.links
        collapsedClasses =
            (if model.headerCollapsed then "collapse"
            else "collapse in") ++ " navbar-collapse"
    in
        header ([ class "col-xs-12 col-sm-12 col-md-12 menu" ] ) --++ styles )
            [ nav [ class "navbar navbar-default" ]
              [ div [ class "container" ]
                [ div [ class "navbar-header" ]
                  [ a [ href "#home" ]
                    [ div [ class "logo" ] [] ]
                  , button [ class "navbar-toggle", onClick ToggleNavbar ]
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


{-| Type of the port needed to get scroll values.
    
    -- declaring the port in `Ports.elm` file
    -- need to import Scroll.Move

    port scroll : (Move -> msg) -> Sub msg
-}
type alias Port = Int --(Move -> Msg) -> Sub Msg

{-| Provide the subscription to the JS port which brings the scroll values.
    The port named 'scroll' needs to be fed with window's scroll event.

    -- insert the subscription in you subscription loop
    subscriptions model =
        List.map (Platform.Sub.map StickyHeaderMsg) (StickyHeader.subscriptions model.headerModel)
        |> Sub.batch

    -- initialize port in your javascript code
    <script>
        // init myApp with Elm.Main
        var mountNode = document.getElementById('main');
        var myApp = Elm.Main.embed(mountNode);

        // get the port
        var scroll = window.pageYOffset || document.body.scrollTop;

        // on window's scroll, send the current values
        window.onscroll = function() {
            var newScroll = window.pageYOffset || document.body.scrollTop;
            myApp.ports.scroll.send([scroll, newScroll]);
            scroll = newScroll;
        };
    </script>

-}
subscriptions : Port -> Model -> List (Sub Msg)
subscriptions portForScroll model = []
{--
    [ portForScroll Header
    , Animation.subscription Animate [ model.style ]
    ]
--}