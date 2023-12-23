module Main exposing (main)

import Browser
import Browser.Dom exposing (Viewport)
import Debug exposing (toString)
import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)
import Task exposing (..)


type alias Model =
    { viewport : Maybe Viewport }


-- https://ellie-app.com/3nw5FhVJYL4a1
{- init : () -> ( Model, Cmd Msg )
   init _ =
       ( { viewport = Nothing }, Cmd.none )
-}
-- If you wanted to measure the viewport on init


init : () -> ( Model, Cmd Msg )
init _ =
    ( { viewport = Nothing }, Task.perform GotViewport Browser.Dom.getViewport )


type Msg
    = GotViewport Viewport


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotViewport viewport ->
            ( { model | viewport = Just viewport }, Cmd.none )


intToStringWithSpace : Int -> String
intToStringWithSpace x =
    toString x ++ " "


vbs : Int -> Int -> Int -> Int -> String
vbs x y w h =
    intToStringWithSpace x ++ intToStringWithSpace y ++ intToStringWithSpace w ++ intToStringWithSpace h


view : Model -> Html Msg
view model =
    svg
        [ viewBox
            (vbs
                0
                0
                (case model.viewport of
                    Nothing ->
                        0

                    Just viewport ->
                        round viewport.viewport.width
                )
                (case model.viewport of
                    Nothing ->
                        0

                    Just viewport ->
                        round viewport.viewport.height
                )
            )
        , fill "red"
        ]
        [ rect
            [ x "10"
            , y "10"
            , width "100"
            , height "100"
            , rx "15"
            , ry "15"
            ]
            []
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , subscriptions = \_ -> Sub.none
        , update = update
        }
