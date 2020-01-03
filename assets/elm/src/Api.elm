module Api exposing (Chart, Song)


type alias Chart =
    { level : Int
    , pattern : String
    , jacketUrl : String
    , chartUrl : Maybe String
    }


type alias Song =
    { id : Int
    , title : String
    , artist : String
    , charts : List Chart
    }
