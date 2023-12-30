module Conversion exposing (percentF, percentI, percentOf, pixel)


percentI : Int -> String
percentI a =
    String.fromInt a ++ "%"


percentF : Float -> String
percentF a =
    String.fromFloat a ++ "%"


percentOf : { x : Float, of_ : Int } -> Int
percentOf d =
    let
        f =
            d.x / toFloat 100
    in
    round (f * toFloat d.of_)


pixel : Int -> String
pixel a =
    String.fromInt a ++ "px"
