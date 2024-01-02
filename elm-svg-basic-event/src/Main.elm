module Main exposing (main)

import Browser
import Json.Decode as Decode
import Svg exposing (Svg)
import Svg.Attributes as Attributes
import Svg.Events as Events


type alias Model =
    { position : ( Int, Int ) }


initialModel : Model
initialModel =
    { position = ( 160, 120 ) }


type Msg
    = Position Int Int


update : Msg -> Model -> Model
update (Position x y) model =
    { model | position = Debug.log "position" ( x, y ) }


view : Model -> Svg Msg
view model =
    let
        radius =
            4

        ( x, y ) =
            model.position

        cx =
            x - radius // 2

        cy =
            y - radius // 2
    in
    Svg.svg
        [ Attributes.width "320"
        , Attributes.height "240"
        , Events.on "svgclick" <|
            Decode.map2 Position
                (Decode.at [ "detail", "x" ] Decode.int)
                (Decode.at [ "detail", "y" ] Decode.int)
        ]
        [ Svg.text_
            [ Attributes.x "10"
            , Attributes.y "20"
            , Attributes.fill "black"
            ]
            [ Svg.text <| String.join ", " <| List.map String.fromInt [ x, y ]
            ]
        , Svg.circle
            [ Attributes.cx <| String.fromInt cx
            , Attributes.cy <| String.fromInt cy
            , Attributes.r <| String.fromInt radius
            , Attributes.fill "orange"
            , Attributes.stroke "black"
            , Attributes.strokeWidth "2"
            ]
            []
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
