module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Background exposing (..)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Track



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


mockModel : Int -> String -> Track.Model
mockModel index name =
    { name = name, index = index }


view : Model -> Html Msg
view model =
    layout [] <|
        row [ height fill, width fill ]
            [ Track.table (List.indexedMap mockModel [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J" ])
            ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
