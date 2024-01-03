module StateModal exposing (getStateModel, modal, withDefaultStateModel)

import Common exposing (..)
import Conversion exposing (..)
import Rect exposing (..)
import Svg exposing (..)
import Svg.Attributes as SA exposing (..)
import Svg.Events as SE exposing (..)
import Text exposing (..)


type StateModel
    = StateModel
        { id : String
        , size : Size
        , position : Position
        , testNumber : Int -- Delete ME
        }



{- type Msg = OnSvgClick Int -}
-- TODO: ID should be unique for each of the StateModel


withDefaultStateModel : String -> StateModel
withDefaultStateModel id =
    getStateModel
        { id = id
        , size = getSize { width = 300, height = 500 }
        , position = getPosition { x = 100, y = 100 }
        }


getStateModel : { id : String, size : Size, position : Position } -> StateModel
getStateModel m =
    StateModel { id = m.id, size = m.size, position = m.position, testNumber = 0 }



{- update : Msg -> StateModel -> ( StateModel, Cmd Msg )
   update msg model =
       case msg of
           OnSvgClick v ->
             ({model | testNumber = v + 1}, Cmd.none)
-}


modal : StateModel -> Svg msg
modal (StateModel mp) =
    let
        posX =
            String.fromInt <| getX mp.position

        -- String.fromInt 300
        posY =
            String.fromInt <| getY mp.position

        -- String.fromInt 100
        svgWidth =
            getWidth mp.size

        -- 300
        svgHeight =
            getHeight mp.size

        -- 500
        svgOpacity =
            100 |> percentI

        w =
            100

        h =
            50

        rx =
            percentOf { x = 0.3, of_ = svgWidth }

        ry =
            percentOf { x = 0.3, of_ = svgHeight }

        rt : Rect.Attributes
        rt =
            { size = getSize { width = w, height = h }
            , position = getPosition { x = 0, y = 0 }
            , cornerRadius = getCornerRadius { rx = rx, ry = ry }
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
                    | size = getSize { width = lw, height = lh }
                    , position = getPosition { x = ox, y = oy }
                    , cornerRadius =
                        getCornerRadius
                            { rx = percentOf { x = 1, of_ = lw }
                            , ry = percentOf { x = 1, of_ = lw }
                            }
                }
                { pa | fill = "lightblue" }

        ht =
            let
                oy =
                    5

                ox =
                    oy // 2

                lw =
                    w - oy

                lh =
                    7

                b =
                    { rt
                        | size = getSize { width = lw, height = lh }
                        , position = getPosition { x = ox, y = oy }
                        , cornerRadius =
                            getCornerRadius
                                { rx = percentOf { x = 1, of_ = lw }
                                , ry = percentOf { x = 1, of_ = lw }
                                }
                    }
            in
            stateText b.position mp.id

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
                    | size = getSize { width = lw, height = lh }
                    , position = getPosition { x = ox, y = oy }
                    , cornerRadius =
                        getCornerRadius
                            { rx = percentOf { x = 1, of_ = lw }
                            , ry = percentOf { x = 1, of_ = lw }
                            }
                }
                { pa | fill = "lightblue" }
    in
    svg
        [ x posX
        , y posY
        , width (svgWidth |> pixel)
        , height (svgHeight |> pixel)
        , opacity svgOpacity
        ]
        [ body
        , header
        , ht
        , footer
        ]
