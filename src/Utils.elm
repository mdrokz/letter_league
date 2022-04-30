module Utils exposing (Tile, TileType, Vector, generateGrid)

import Array
import List exposing (head)
import Random exposing (Seed)
import LetterBag exposing (x)


type alias Vector =
    { x : Int
    , y : Int
    }


type TileType
    = Normal String
    | Double String
    | Triple String


type alias Tile =
    { tile : TileType
    , position : Vector
    }


generateGrid : Int -> List (List Tile)
generateGrid size =
    List.repeat size (List.repeat size { tile = Normal "", position = { x = 0, y = 0 } })


letters : List String
letters =
    [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "O", "M", "N", "P", "Q", "R", "S", "T", "U", "W", "W", "X", "Y", "Z" ]


letters_seed =
    letters
        |> List.map
            (\x ->
                let
                    result =
                        x |> String.toList |> head
                in
                Maybe.withDefault (Char.fromCode 0) result
            )
        |> List.map Char.toCode
        |> List.sum


select_letter : Int -> String
select_letter index =
    let
        result =
            Array.fromList letters |> Array.get index
    in
    Maybe.withDefault "" result


seed : Seed
seed =
    Random.initialSeed letters_seed


range : Int -> Int -> Int -> Int
range max min magic =
    let
        ( result, _ ) =
            Random.step (Random.int min max) seed
    in
    result - magic


range2 : Int -> Int -> Int
range2 max min =
    let
        ( result, _ ) =
            Random.step (Random.int min max) seed
    in
    result


generateLetters : Int -> List String
generateLetters size =
    letters |> List.append (List.repeat (size - List.length letters) (select_letter (range2 0 26)))


sortLetters : String -> String -> Order
sortLetters a b =
    let
        result =
            a |> String.toList |> List.head

        x =
            Maybe.withDefault (Char.fromCode 0) result |> Char.toCode

        result2 =
            b |> String.toList |> List.head

        x2 =
            Maybe.withDefault (Char.fromCode 0) result2 |> Char.toCode

        y =
            range 26 50 x

        y2 =
            range 26 50 x2
    in
    compare y y2


shuffleLetters : List String -> List String
shuffleLetters list =
    list |> List.reverse |> List.sortWith (\a b -> sortLetters a b)
