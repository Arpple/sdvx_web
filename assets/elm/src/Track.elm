module Track exposing (Model, table)

import Api exposing (Chart, Song)
import Element exposing (..)
import Element.Background as Background
import Element.Events exposing (..)
import Element.Font as Font
import List.Split exposing (chunksOfLeft)
import Util


type alias Model =
    Song


selectionEffect : Attribute msg
selectionEffect =
    mouseOver [ Background.color <| rgb255 200 255 200 ]


trackAttr : List (Attribute msg)
trackAttr =
    [ spacing 15
    , height fill
    , width fill
    , padding 15
    ]


bgColor : Color
bgColor =
    rgb255 230 230 230


chartDetail : Chart -> Element msg
chartDetail chart =
    let
        str =
            chart.pattern ++ " : " ++ String.fromInt chart.level
    in
    case chart.chartUrl of
        Just url ->
            link [ Font.size 16 ] { url = url, label = text <| str }

        Nothing ->
            el [ Font.size 16, Font.color <| rgb255 150 150 150 ] <| text str


trackDetail : Maybe Model -> Element msg
trackDetail maybeModel =
    case maybeModel of
        Just model ->
            let
                last =
                    List.reverse model.charts |> List.head
            in
            case last of
                Nothing ->
                    el [] (text "")

                Just l ->
                    column
                        (trackAttr ++ [ Background.color bgColor, selectionEffect ])
                        ([ el [ centerX ] <| image [] { src = l.jacketUrl, description = "" }
                         , el [ centerX ] <| text model.title
                         ]
                            ++ List.map chartDetail model.charts
                        )

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
    in
    column [ height fill, width fill, Background.color <| rgb255 255 255 255 ] <|
        List.map trackRow chunked
