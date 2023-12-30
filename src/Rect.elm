module Rect exposing (Attributes, Presentation, rect)

import Common exposing (..)
import Conversion exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


type alias Attributes =
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


rect : Attributes -> Presentation -> Svg msg
rect rA pA =
    let
        posx =
            getX rA.position |> percentI

        posy =
            getY rA.position |> percentI

        w =
            getWidth rA.size |> percentI

        h =
            getHeight rA.size |> percentI

        crx =
            getRx rA.cornerRadius |> percentI

        cry =
            getRy rA.cornerRadius |> percentI

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
