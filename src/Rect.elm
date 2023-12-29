module Rect exposing (Attributes, Presentation, rect)

import Common exposing (..)
import Conversion exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


type alias Attributes =
    { size : Size
    , cornerRadius : RadiusXY
    , position : Position
    }


type alias Presentation =
    { fill : String
    , stroke : Int
    , storkeWidht : Int
    , opacity : Int
    }


rect : Attributes -> Presentation -> Svg msg
rect rA pA =
    let
        posx =
            rA.position.x |> percentI

        posy =
            rA.position.y |> percentI

        w =
            rA.size.width |> percentI

        h =
            rA.size.height |> percentI

        crx =
            rA.cornerRadius.rx |> percentI

        cry =
            rA.cornerRadius.ry |> percentI

        sw =
            pA.storkeWidht |> percentI

        strk =
            pA.stroke |> percentI

        opcity =
            pA.opacity |> percentI

        f =
            pA.fill
    in
    Svg.rect
        [ -- Rectangle Attributes
          x posx
        , y posy
        , width w
        , height h
        , rx crx
        , ry cry

        -- Presentation Attributes
        , fill f
        , strokeWidth sw
        , stroke strk
        , opacity opcity
        ]
        []
