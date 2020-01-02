module Main exposing (..)

import Api exposing (Song)
import Browser
import Element exposing (..)
import Element.Background exposing (..)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Http
import Json.Decode as JD exposing (Decoder, field, int, list, nullable, string)
import Track



---- MODEL ----


type Model
    = Failure
    | Loading
    | Success (List Song)


type Msg
    = GotText (Result Http.Error (List Song))


songDecoder : Decoder Song
songDecoder =
    JD.map7 Song
        (field "id" int)
        (field "title" string)
        (field "artist" string)
        (field "level" int)
        (field "pattern" string)
        (field "jacket_url" string)
        (field "chart_url" (nullable string))


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "/api/songs"
        , expect = Http.expectJson GotText (list songDecoder)
        }
    )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok songs ->
                    ( Success songs, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            Html.text "Error"

        Loading ->
            Html.text "Loading..."

        Success songs ->
            layout [] <|
                row [ height fill, width fill ]
                    [ Track.table songs
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
