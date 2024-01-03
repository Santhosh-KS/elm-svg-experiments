module Text exposing (..)

import Common exposing (..)
import Conversion exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)



{- type alias Attributes =
       { size : Size
       , cornerRadius : CornerRadius
       , position : Position
       }


   type alias Presentation =
       { fill : String
       , stroke : Int
       , storkeWidht : Int
       , opacity : Int
       }
-}


stateText : Position -> String -> Svg msg
stateText p v =
    Svg.text_
        [ x <| percentI <| getX p
        , y <| percentI <| getY p
        , fill "red"

        -- , textAnchor "middle"
        , dominantBaseline "central"
        ]
        [ text v
        ]
