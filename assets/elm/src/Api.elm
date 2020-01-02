module Api exposing (Song)


type alias Song =
    { id : Int
    , title : String
    , artist : String
    , level : Int
    , pattern : String
    , jacketUrl : String
    , chartUrl : Maybe String
    }
