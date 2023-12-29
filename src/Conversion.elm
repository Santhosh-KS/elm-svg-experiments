module Conversion exposing (percentF, percentI, percentOf, pixel)


percentI : Int -> String
percentI a =
    String.fromInt a ++ "%"


percentF : Float -> String
percentF a =
    String.fromFloat a ++ "%"


percentOf : Float -> Int -> Int
percentOf n w =
    let
        f =
            n / toFloat 100
    in
    round (f * toFloat w)


pixel : Int -> String
pixel a =
    String.fromInt a ++ "px"
