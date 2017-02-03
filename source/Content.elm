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
venueView : Html a
venueView =
  markDownWithDefault
  """
###### This event will be kindly hosted by Microsoft at the [Microsoft Innovation Center](https://www.microsoftinnovationcenters.com/locations/malta), located 
at the SkyParks Business Center, Luqa.

###### We'll provide food and drinks, you'll bring your passion for web-development!

<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3233.938068431182!2d14.49330431657561!3d35.850522115308074!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMzXCsDUxJzA0LjYiTiAxNMKwMjknMzkuNSJF!5e0!3m2!1sen!2sit!4v1476439123047" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
  """
    
{-| Renders the HTML for the Event section: what are we talking about.

    eventView
-}
eventView : Html a
eventView =
  markDownWithDefault
  """
Join us on **Saturday, 29th October 2016 at 12.00AM**, for the first MaltaJS talk.

We will talk about [Elm](http://elm-lang.org/), a new functional language which compiles to Javascript and
enforces immutability and single source of truth.

One of the advantages is that within the Elm code **run-time exceptions are virtually impossible**: the compiler 
prevents the developer from using the wrong types, keys and values of the records are checked at compile time, every value is immutable
 and use of side-effects is strictly supervised.

Furthermore, it forces the developer to design the application in terms of one centralized state which reacts to messages, the so called
 [Elm Architecture](https://github.com/evancz/elm-architecture-tutorial).

The [Redux](https://github.com/reactjs/redux#thanks) project was actually inspired also by the Elm Architecture.
  """
  
privacyView : Html a
privacyView =
  -- Markdown.toHtml [ class (String.join " " ["alert", "small", "alert-info"]) ]
  markDownWithDefault
  """
By signing up, you agree with with our <a href="privacy-policy" target="_blank">privacy policy</a>.
  """
  
formErrorView : Html a
formErrorView =
  markDownWithDefault
  """
Please fill in all the required field
  """
