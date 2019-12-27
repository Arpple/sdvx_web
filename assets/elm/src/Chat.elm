module Chat exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font


msgPanel : Element msg
msgPanel =
    column [ height fill, width <| fillPortion 5 ]
        [ text "chat" ]


channelPanel : Element msg
channelPanel =
    column
        [ height fill
        , width <| fillPortion 1
        , Background.color <| rgb255 92 99 118
        , Font.color <| rgb255 255 255 255
        ]
        [ text "channels" ]
