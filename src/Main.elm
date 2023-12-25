module Main exposing
    ( appendSpace
    , defaultViewPort
    , main
    , percentF
    , percentI
    , range0To255
    )

import Browser
import Browser.Dom exposing (Viewport)
import Browser.Events
import Debug exposing (toString)
import GridPattern exposing (..)
import Html exposing (Html)
import List exposing (append)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)
import Task exposing (..)


type alias Model =
    { viewport : Viewport }



-- https://ellie-app.com/3nw5FhVJYL4a1
{- init : () -> ( Model, Cmd Msg )
   init _ =
       ( { viewport = Nothing }, Cmd.none )
-}
-- If you wanted to measure the viewport on init


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
    ( { viewport = defaultViewPort }
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotViewport viewport ->
            ( { model | viewport = viewport }, Cmd.none )

        BrowserResized _ _ ->
            ( model, viewportTask )


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


percentI : Int -> String
percentI a =
    String.fromInt a ++ "%"


percentF : Float -> String
percentF a =
    String.fromFloat a ++ "%"


percentIWithSpace : Int -> String
percentIWithSpace a =
    appendSpace <| percentI a


pixel : Int -> String
pixel a =
    String.fromInt a ++ "px"


seconds : a -> String
seconds a =
    toString a ++ "s"


rgb : Float -> Float -> Float -> String
rgb r g b =
    -- "rgb(" ++ percentIWithSpace (range0To255 r) ++ percentIWithSpace (range0To255 g) ++ percentIWithSpace (range0To255 b) ++ "/ 100%)"
    "rgb(0% 50% 0% / 100%)"


range0To255 : Float -> Float
range0To255 x =
    if x > 255 then
        255

    else if x < 0 then
        0

    else
        x


normalizeTo100 : Float -> Int
normalizeTo100 x =
    round <| range0To255 x / 255 * 100


percentString : Int -> String
percentString x =
    x
        |> percentI
        |> appendSpace



-- conditional rendering is possible
-- https://discourse.elm-lang.org/t/are-there-any-common-patters-for-dealing-with-conditionally-including-markup/5242/6


svgElements : List (Svg msg)
svgElements =
    gridPattern



-- append gridPattern gridPattern


view : Model -> Html Msg
view model =
    svg
        [ viewBox
            (vbs
                0
                0
                (round model.viewport.viewport.width)
                (round model.viewport.viewport.height)
            )
        , fill "blue"
        ]
        svgElements



{- [ rect
       [ x <| String.fromInt 10
       , y <| String.fromInt 10
       , width <| percentI 10
       , height <| percentI 10
       , rx <| percentF 0.5
       , ry <| percentF 0.5
       ]
       [ animate
           [ attributeName "fill"
           , dur <| seconds 10
           , from <| rgb 0 255 0
           , to "magenta"
           , fill "freeze"
           ]
           []
       ]
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
