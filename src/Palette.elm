module Palette exposing (blogHeading, color)

import Element exposing (Element)
import Element.Font as Font
import Element.Region


color :
    { primary : Element.Color
    , secondary : Element.Color
    }
color =
    { primary = Element.rgb255 5 117 230
    , secondary = Element.rgb255 0 242 96
    }


blogHeading : String -> Element msg
blogHeading title =
    Element.paragraph
        [ Font.bold
        , Element.Region.heading 1
        , Font.size 36
        , Font.color (Element.rgb255 43 188 138)
        ]
        [ Element.text title ]
