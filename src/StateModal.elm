module StateModal exposing (modal)

import Common exposing (..)
import Conversion exposing (..)
import Rect exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


modal : Svg msg
modal =
    let
        posX =
            String.fromInt 300

        posY =
            String.fromInt 300

        svgWidth =
            300

        svgHeight =
            300

        svgOpacity =
            100 |> percentI

        w =
            100

        h =
            50

        rx =
            percentOf 0.3 svgWidth

        ry =
            percentOf 0.3 svgHeight

        rt : Rect.Attributes
        rt =
            { size = getSize w h
            , position = getPosition 0 0
            , cornerRadius = getRadiusXY rx ry
            }

        pa : Rect.Presentation
        pa =
            { storkeWidht = 10
            , stroke = 10
            , fill = "white"
            , opacity = 100
            }

        body : Svg msg
        body =
            Rect.rect rt { pa | opacity = 20 }

        header : Svg msg
        header =
            let
                oy =
                    2

                ox =
                    oy // 2

                lw =
                    w - oy

                lh =
                    7
            in
            Rect.rect
                { rt
                    | size = { width = lw, height = lh }
                    , position = { x = ox, y = oy }
                    , cornerRadius = { rx = percentOf 1 lw, ry = percentOf 1 lw }
                }
                { pa | fill = "lightblue" }

        footer : Svg msg
        footer =
            let
                oy =
                    h - lh - 1

                ox =
                    1

                lw =
                    w - 2

                lh =
                    3
            in
            Rect.rect
                { rt
                    | size = { width = lw, height = lh }
                    , position = { x = ox, y = oy }
                    , cornerRadius = { rx = percentOf 1 lw, ry = percentOf 1 lw }
                }
                { pa | fill = "lightblue" }
    in
    g []
        [ svg
            [ x posX
            , y posY
            , width (svgWidth |> pixel)
            , height (svgHeight |> pixel)
            , opacity svgOpacity
            ]
            [ body
            , header
            , footer
            ]
        ]
