module Common exposing
    ( CornerRadius
    , Position
    , Size
    , getCornerRadius
    , getHeight
    , getPosition
    , getRx
    , getRy
    , getSize
    , getWidth
    , getX
    , getY
    )


type Position
    = Position
        { x : Int
        , y : Int
        }


type CornerRadius
    = CornerRadius
        { rx : Int
        , ry : Int
        }


type Size
    = Size
        { width : Int
        , height : Int
        }


getSize : { width : Int, height : Int } -> Size
getSize s =
    Size { width = s.width, height = s.height }


getWidth : Size -> Int
getWidth (Size s) =
    s.width


getHeight : Size -> Int
getHeight (Size s) =
    s.height


getPosition : { x : Int, y : Int } -> Position
getPosition p =
    Position { x = p.x, y = p.y }


getX : Position -> Int
getX (Position p) =
    p.x


getY : Position -> Int
getY (Position p) =
    p.y


getCornerRadius : { rx : Int, ry : Int } -> CornerRadius
getCornerRadius cr =
    CornerRadius { rx = cr.rx, ry = cr.ry }


getRx : CornerRadius -> Int
getRx (CornerRadius r) =
    r.rx


getRy : CornerRadius -> Int
getRy (CornerRadius r) =
    r.ry
