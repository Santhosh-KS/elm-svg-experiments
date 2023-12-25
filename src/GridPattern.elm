module GridPattern exposing (gridPattern)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


fillUrl : String -> String
fillUrl id =
    "url(#" ++ id ++ ")"


gridRect : GridPatternProps -> Svg msg
gridRect g =
    rect
        [ width "100%"
        , height "100%"
        , fill <| fillUrl g.id
        ]
        []


type alias GridPatternProps =
    { id : String
    , stroke : String
    , strokeWidth : String
    , path : String
    , width : String
    , height : String
    , fill : String
    , patternUnits : String
    }


defaultGridPattern : GridPatternProps
defaultGridPattern =
    { id = "defaultGridPattern"
    , stroke = "lightBlue"
    , strokeWidth = "0.5"
    , path = "M 0"
    , width = "10"
    , height = "10"
    , fill = "none"
    , patternUnits = "userSpaceOnUse"
    }


smallGridPattern : GridPatternProps -> GridPatternProps
smallGridPattern g =
    { g
        | id = "smallGridPattern"
        , path = "M 10 0 L 0 0 0 10"
        , width = "10"
        , height = "10"
    }


bigGridPattern : GridPatternProps -> GridPatternProps
bigGridPattern g =
    { g
        | id = "bigGridPattern"
        , path = "M 100 0 L 0 0 0 100"
        , width = "100"
        , height = "100"
        , strokeWidth = "0.7"
    }


pattern : GridPatternProps -> Svg msg
pattern g =
    Svg.pattern
        [ id g.id
        , width g.width
        , height g.height
        , patternUnits g.patternUnits
        ]
        [ Svg.path
            [ d g.path
            , fill g.fill
            , stroke g.stroke
            , strokeWidth g.strokeWidth
            ]
            []
        ]


grid : GridPatternProps -> GridPatternProps -> Svg msg
grid s b =
    defs []
        [ pattern s
        , pattern b
        ]


sgProp : GridPatternProps
sgProp =
    smallGridPattern defaultGridPattern


bgProp : GridPatternProps
bgProp =
    bigGridPattern defaultGridPattern


gridPattern : List (Svg msg)
gridPattern =
    [ grid sgProp bgProp
    , gridRect <| sgProp
    , gridRect <| bgProp
    ]
