module Content exposing (..)

{-| This module hosts the actual content of the page. Thus can be edited right here,
    using Markdown. 

# Definition
@docs Content

# Common Helpers
@docs aboutView, venueView, eventView

-}

import Html exposing (Html, h1, div, p, text)
import Html.Attributes exposing (class)
import Markdown
import String
import Shared exposing (..)

defaultClassesWith : List String -> String
defaultClassesWith customClasses =
  [ defaultClasses ] ++ customClasses
  |> String.join " "

defaultClasses = String.join " " [ "col-xs-12" ]

markDownWithDefault = Markdown.toHtml [ class defaultClasses ]


organizers : List Organizer
organizers =
  [ Organizer "Andrei Toma" "andrei@maltajs.com"
  , Organizer "Bogdan Dumitru" "bogdan@maltajs.com"
  , Organizer "Pietro Grandi" "pietro@maltajs.com"
  , Organizer "Organization" "contact@maltajs.com"
  ]


mainEvent = 
  [
    ExtendedSchedule
      "19:30" "20:30"
      "Bundling under the hood"
      "Péter Bakonyi"
      """
      Choosing and configuring a bundling tool is one of the hottest topics among front-end developers. In this presentation we take a deep dive into how Webpack, Rollup and Browserify work internally. The main focus will be on understanding the building blocks and comparing the existing implementations.
      """
      [ ("linkedin", "https://mt.linkedin.com/in/peter-bakonyi-58b68a74")
      , ("github", "https://github.com/peterbakonyi05")
      ]
  ]

preEvents =
  [ Schedule "19:00" "19:15" "WELCOME COFFEE & REGISTRATION"
  , Schedule "19:15" "19:30" "Welcome speech"
  ]

postEvents =
  [ Schedule "20:30" "21:00" "Networking" ]


{-| Renders the HTML for the About section: what is MaltaJS 

    aboutView
-}
aboutView : Html a
aboutView =
  markDownWithDefault
  """
MaltaJS is the new front-end community in Malta: born in 2016 as internal guild at Betsson,
now it is open to all the developers on the island.

Our aim is to provide **a place to share knowledge and technologies**, through meetings and talks.

Do you think you have a good idea for a talk, hackathon, demo or peer-learning?

**Join us** [on Facebook](https://www.facebook.com/groups/941691142568690/) and be part of the community!
  """

{-| Renders the HTML for the Venue section: where there will be the event
 
    venueView
-}
 
formErrorView : Html a
formErrorView =
  markDownWithDefault
  """
Please fill in all the required field
  """

sponsor : Html a
sponsor =
  markDownWithDefault
  """
  ##iGaming Cloud

Who are we? We are entrepreneurs, innovators, igaming enthusiasts with extensive industry experience.

We have created and developed iGC using experts in each area to bring together a lean iGaming Platform which we are proud to call iGaming Cloud.

  """

sponsorLogo =
  "/images/companies/igaming-cloud.svg"


