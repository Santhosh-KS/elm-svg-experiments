module MainTest exposing
    ( appendSpaceTest
    , equalTo97Test
    , greaterThan255Test
    , lessThan255Test
    , percentFTest
    , percentITest
    , suite
    )

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Main exposing (..)
import Test exposing (..)


suite : Test
suite =
    test "one plus one equals two" <| \_ -> Expect.equal 2 (1 + 1)


{- fillUrlTest : Test
fillUrlTest =
    test "Test if fillUrl returns url(#someID)" <| \_ -> Expect.equal "url(#someId)" (fillUrl "someId") -}


percentFTest : Test
percentFTest =
    test "Test Float to string with space % conversion" <| \_ -> Expect.equal "50.1%" (percentF 50.1)


percentITest : Test
percentITest =
    test "Test Int to string with space % conversion" <| \_ -> Expect.equal "50%" (percentI 50)


appendSpaceTest : Test
appendSpaceTest =
    test "Test adding space at the end" <| \_ -> Expect.equal "10 " (appendSpace "10")


lessThan255Test : Test
lessThan255Test =
    test "Test range of negetive numbers" <| \_ -> Expect.equal 0 (range0To255 -10)


greaterThan255Test : Test
greaterThan255Test =
    test "Test range of > 255 numbers" <| \_ -> Expect.equal 255 (range0To255 256)


equalTo97Test : Test
equalTo97Test =
    test "Test range of = 97 numbers" <| \_ -> Expect.equal 97 (range0To255 97)
