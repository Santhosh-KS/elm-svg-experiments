module Main exposing
    ( appendSpace
    , defaultViewPort
    , main
    , range0To255
    )

import Browser
import Browser.Dom exposing (Viewport)
import Browser.Events
import Browser.Navigation exposing (back)
import Common exposing (..)
import Conversion exposing (..)
import Debug exposing (toString)
import GridPattern exposing (..)
import Html exposing (Html, div, input)
import Html.Attributes exposing (contenteditable, placeholder)
import Html.Events exposing (onInput)
import Json.Decode as D exposing (..)
import List exposing (..)
import Rect exposing (..)
import StateModal exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events as SE exposing (..)
import Task exposing (..)
import Browser.Events exposing (onKeyPress)


type alias Model =
    { viewport : Viewport
    , inputText : String
    , testCount : Int
    , premetives : List (Svg Msg)
    }


defaultText =
    "Hello"


ifIsEnter : msg -> D.Decoder msg
ifIsEnter msg =
  D.field "key" D.string
    |> D.andThen (\key -> if key == "Enter" then D.succeed msg else D.fail "some other key")

-- mousemove


onMouseMove : msg -> Attribute msg 
onMouseMove msg =
    SE.on "mousemove" (D.succeed msg)


defaultViewPort : Viewport
defaultViewPort =
    { scene =
        { width = 0
        , height = 0
        }
    , viewport =
        { x = 0
        , y = 0
        , width = 0
        , height = 0
        }
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { viewport = defaultViewPort, inputText = defaultText, testCount = 0, premetives = basicPremitives }
    , viewportTask
    )


viewportTask : Cmd Msg
viewportTask =
    Task.perform GotViewport Browser.Dom.getViewport


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onResize BrowserResized


type Msg
    = GotViewport Viewport
    | BrowserResized Int Int
    | OnSvgClick Int


findTheState : Model -> ( Model, Cmd Msg )
findTheState m =
    ( m, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotViewport viewport ->
            ( { model | viewport = viewport }, Cmd.none )

        BrowserResized _ _ ->
            ( model, viewportTask )

        OnSvgClick v ->
            let
                nn =
                    getStateModel
                        { id = "State-" ++ String.fromInt v
                        , size = getSize { width = 300 + v * 10, height = 500 + v * 10 }
                        , position = getPosition { x = 100 + v * 10, y = 100 + v * 10 }
                        }
            in
            ( { model
                | testCount = v + 1
                , premetives = updatePremitives model.premetives (modal nn)
              }
            , Cmd.none
            )


appendSpace : String -> String
appendSpace x =
    x ++ " "


vbs : Int -> Int -> Int -> Int -> String
vbs x y w h =
    String.fromInt x
        ++ " "
        ++ String.fromInt y
        ++ " "
        ++ String.fromInt w
        ++ " "
        ++ String.fromInt h


range0To255 : Float -> Float
range0To255 x =
    if x > 255 then
        255

    else if x < 0 then
        0

    else
        x



-- conditional rendering is possible
-- https://discourse.elm-lang.org/t/are-there-any-common-patters-for-dealing-with-conditionally-including-markup/5242/6


backgroundRect : Int -> Svg msg
backgroundRect v =
    let
        color =
            if modBy 2 v == 0 then
                "rgb(10% 10% 10% / 100%)"

            else
                "rgb(30% 30% 30% / 100%)"
    in
    Svg.rect
        [ width "100%"
        , height "100%"
        , fill color
        ]
        []


type alias RectXYWH =
    { x : Int
    , y : Int
    , width : Int
    , height : Int
    , color : String
    }


banner : RectXYWH -> Html msg
banner r =
    svg
        [ x <| String.fromInt <| r.x
        , y <| String.fromInt <| r.y
        , width <| String.fromInt <| r.width
        , height <| String.fromInt <| r.height
        ]
        [ Svg.rect
            [ width "100%"
            , height "100%"
            , fill r.color
            ]
            []
        ]


myText : Svg msg
myText =
    Svg.text_
        [ x "130"
        , y "130"
        , fill "blue"
        , textAnchor "middle"
        , dominantBaseline "central"
        ]
        [ text "Howdy"
        ]


fod : Svg msg
fod =
    foreignObject
        [ x "120"
        , y "120"
        , width "60"
        , height "160"
        , fill "white"
        , stroke "white"
        ]
        [ div [ contenteditable True ] [ text "EditMe" ]
        ]


basicPremitives : List (Svg msg)
basicPremitives =
    [ backgroundRect 0
    , grid sgProp bgProp
    , smallGrid
    , bigGrid
    ]


updatePremitives : List (Svg msg) -> Svg msg -> List (Svg msg)
updatePremitives ls d =
    append ls (singleton d)


view : Model -> Html Msg
view model =
    let
        w =
            round model.viewport.viewport.width

        h =
            round model.viewport.viewport.height

        headerSize =
            50

        leftBarSize =
            headerSize - 10

        rightBarSize =
            headerSize - 15

        footerSize =
            headerSize - 20

        fy =
            h - footerSize

        rbx =
            w - rightBarSize

        header =
            banner <| RectXYWH 0 0 w headerSize "red"

        footer =
            banner <| RectXYWH 0 fy w footerSize "red"

        leftBar =
            banner <| RectXYWH 0 0 leftBarSize h "green"

        rightBar =
            banner <| RectXYWH rbx 0 leftBarSize h "green"
    in
    svg
        [ viewBox <| vbs 0 0 w h
        , fill "blue"
        , id "MainSvg"
        -- , SE.onClick <| OnSvgClick model.testCount
        -- , SE.on "wheel" <| D.succeed <| OnSvgClick model.testCount
        -- , SE.on "contextmenu" <| (D.succeed <| OnSvgClick model.testCount)
        -- , SE.on "pointerdown" <| (D.succeed <| OnSvgClick model.testCount)
        -- pointer events https://www.youtube.com/watch?v=MhUCYR9Tb9c&t=10s
        -- https://www.youtube.com/watch?v=XF1_MlZ5l6M Event listners
        , SE.on "pointermove" <| (D.succeed <| OnSvgClick model.testCount)
        -- TODO
        -- https://discourse.elm-lang.org/t/triggering-arrowup-in-elm-spc/6457/4
        -- not working list
        -- , SE.on "keypress" <| (D.succeed <| OnSvgClick model.testCount)
        -- , SE.on "keydown" <| (D.succeed <| OnSvgClick model.testCount)
        -- , SE.on "scroll" <| D.succeed <| OnSvgClick model.testCount
        ]
        model.premetives



{- [ backgroundRect model.testCount
   , grid sgProp bgProp
   , smallGrid
   , bigGrid
   , leftBar
   , header
   , modal <| withDefaultStateModel "State-XYZ"
   ]
-}
{- [ backgroundRect
   , grid sgProp bgProp
   , smallGrid
   , bigGrid
   , leftBar
   , rightBar
   , header
   , footer
   , myText
   , fod
   ]
-}


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }
