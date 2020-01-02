module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Background exposing (..)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Http
import Track



---- MODEL ----


type Model
    = Failure
    | Loading
    | Success String


type Msg
    = GotText (Result Http.Error String)


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "/api/songs"
        , expect = Http.expectString GotText
        }
    )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )



---- VIEW ----


mockModel : Int -> String -> Track.Model
mockModel index name =
    { name = name, index = index }


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            Html.text "Error"

        Loading ->
            Html.text "Loading..."

        Success fullText ->
            layout [] <|
                row [ height fill, width fill ]
                    [ Track.table (List.indexedMap mockModel [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J" ])
                    , Element.text fullText
                    ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
