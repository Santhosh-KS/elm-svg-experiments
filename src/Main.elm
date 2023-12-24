module Main exposing (main)

import Browser
import Browser.Dom exposing (Viewport)
import Browser.Events
import Debug exposing (toString)
import Html exposing (Html)
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


subscriptions : a -> Sub Msg
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


appendSpace : a -> String
appendSpace x =
    toString x ++ " "


vbs : Int -> Int -> Int -> Int -> String
vbs x y w h =
    appendSpace x ++ appendSpace y ++ appendSpace w ++ appendSpace h


view : Model -> Html Msg
view model =
    svg
        [ viewBox
            (vbs
                0
                0
                (round model.viewport.scene.width)
                (round model.viewport.scene.height)
            )
        , fill "blue"
        ]
        [ rect
            [ x "10"
            , y "10"
            , width "10%"
            , height "10%"
            , rx "15%"
            , ry "15%"
            ]
            [ animate
                [ attributeName "fill"
                , dur "10s"
                , from "green"
                , to "magenta"
                , fill "freeze"
                ]
                []
            ]
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }
