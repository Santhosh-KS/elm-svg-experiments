module Common exposing
    ( Position
    , RadiusXY
    , Size
    , getPosition
    , getRadiusXY
    , getSize
    )


type alias Position =
    { x : Int
    , y : Int
    }


type alias RadiusXY =
    { rx : Int
    , ry : Int
    }


type alias Size =
    { width : Int
    , height : Int
    }


getSize : Int -> Int -> Size
getSize w h =
    { width = w, height = h }


getPosition : Int -> Int -> Position
getPosition x y =
    { x = x, y = y }


getRadiusXY : Int -> Int -> RadiusXY
getRadiusXY x y =
    { rx = x, ry = y }
