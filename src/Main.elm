module Main exposing (fillUrl, main, percentF, percentI, defaultViewPort)

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



{- percent : a -> String
   percent x =
     if x == Int  then
       String.fromInt x ++ "%"
     else if x == Float then
       String.fromFloat x ++ "%"
     else "%"
-}


percentWithSpace : Int -> String
percentWithSpace a =
    appendSpace <| percentI a


pixel : Int -> String
pixel a =
    String.fromInt a ++ "px"


seconds : a -> String
seconds a =
    toString a ++ "s"


rgb : Int -> Int -> Int -> String
rgb r g b =
    -- "rgb(" ++ percentWithSpace r ++ percentWithSpace g ++ percentWithSpace b ++ appendSpace "/" ++ percentWithSpace a ++ ")"
    "rgb(0% 50% 0% / 100%)"



-- "rgb(" ++ percentWithSpace (range0To255 r) ++ percentWithSpace (range0To255 g) ++ percentWithSpace (range0To255 b) ++ "/ 100%)"


range0To255 : Int -> Int
range0To255 x =
    if x > 255 then
        100

    else if x < 0 then
        0

    else
        (x // 255) * 100



-- conditional rendering is possible
-- https://discourse.elm-lang.org/t/are-there-any-common-patters-for-dealing-with-conditionally-including-markup/5242/6


fillUrl : String -> String
fillUrl id =
    "url(#" ++ id ++ ")"


gridRect : GridPatternProps -> Svg msg
gridRect g =
    rect
        [ width "100%"
        , height "100%"
        , fill <| fillUrl g.id
        ]
        []


myRect : Model -> Svg msg
myRect model =
    rect
        [ x <| String.fromInt 10
        , y <| String.fromInt 10
        , width <| percentI 10
        , height <| percentI 10
        , rx <| percentF 10
        , ry <| percentF 0.8
        ]
        []


type alias GridPatternProps =
    { id : String
    , stroke : String
    , strokeWidth : String
    , path : String
    , width : String
    , height : String
    , fill : String
    , patternUnits : String
    }


defaultGridPattern : GridPatternProps
defaultGridPattern =
    { id = "defaultGridPattern"
    , stroke = "lightBlue"
    , strokeWidth = "0.5"
    , path = "M 0"
    , width = "10"
    , height = "10"
    , fill = "none"
    , patternUnits = "userSpaceOnUse"
    }


smallGridPattern : GridPatternProps -> GridPatternProps
smallGridPattern g =
    { g
        | id = "smallGridPattern"
        , path = "M 10 0 L 0 0 0 10"
        , width = "10"
        , height = "10"
    }


bigGridPattern : GridPatternProps -> GridPatternProps
bigGridPattern g =
    { g
        | id = "bigGridPattern"
        , path = "M 100 0 L 0 0 0 100"
        , width = "100"
        , height = "100"
        , strokeWidth = "0.7"
    }


grid : GridPatternProps -> Svg msg
grid prop =
    defs []
        [ pattern
            [ id prop.id
            , width prop.width
            , height prop.height
            , patternUnits prop.patternUnits
            ]
            [ Svg.path
                [ d prop.path
                , fill prop.fill
                , stroke prop.stroke
                , strokeWidth prop.strokeWidth
                ]
                []
            ]
        ]


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
        [ grid <| smallGridPattern defaultGridPattern
        , gridRect <| smallGridPattern defaultGridPattern
        , grid <| bigGridPattern defaultGridPattern
        , gridRect <| bigGridPattern defaultGridPattern
        ]



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
