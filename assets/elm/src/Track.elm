module Track exposing (Model, table)

import Api exposing (Song)
import Element exposing (..)
import Element.Background as Background
import Element.Events exposing (..)
import List.Split exposing (chunksOfLeft)
import Util


type alias Model =
    Song


selectionEffect : Attribute msg
selectionEffect =
    mouseOver [ Background.color <| rgb255 86 182 139 ]


trackAttr : List (Attribute msg)
trackAttr =
    [ spacing 15
    , height fill
    , width fill
    ]


bgColor : Color
bgColor =
    rgb255 100 100 100


trackDetail : Maybe Model -> Element msg
trackDetail maybeModel =
    case maybeModel of
        Just model ->
            el
                (trackAttr ++ [ Background.color bgColor, selectionEffect ])
                (text model.title)

        Nothing ->
            el
                trackAttr
                (text "")


track : Maybe Model -> Element msg
track maybeModel =
    column
        [ width fill
        , padding 15
        , spacing 7
        ]
        [ trackDetail maybeModel ]


trackRow : List (Maybe Model) -> Element msg
trackRow tracks =
    row [ height fill, width fill ] <|
        List.map track tracks


table : List Model -> Element msg
table tracks =
    let
        chunked =
            tracks
                |> List.map Just
                |> chunksOfLeft 3
                |> List.map (Util.padList 3 Nothing)

        x =
            Debug.log (String.fromInt (List.length tracks))
    in
    column [ height fill, width fill, Background.color <| rgb255 255 255 255 ] <|
        List.map trackRow chunked
