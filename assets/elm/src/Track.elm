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
    rgb255 230 230 230


sdvxInLink : Maybe String -> Element msg
sdvxInLink maybeUrl =
    case maybeUrl of
        Just url ->
            link [] { url = url, label = text "sdvx.in" }

        Nothing ->
            text ""


trackDetail : Maybe Model -> Element msg
trackDetail maybeModel =
    case maybeModel of
        Just model ->
            column
                (trackAttr ++ [ Background.color bgColor, selectionEffect ])
                [ el [] <| image [] { src = model.jacketUrl, description = "" }
                , el [] <| text model.title
                , el [] <| text (String.fromInt model.level)
                , sdvxInLink model.chartUrl
                ]

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
