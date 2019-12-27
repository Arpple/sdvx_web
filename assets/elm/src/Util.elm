module Util exposing (..)


padList : Int -> a -> List a -> List a
padList n elem list =
    if List.length list >= n then
        list

    else
        padList n elem (list ++ [ elem ])
