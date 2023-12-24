module MainTest exposing (suite, fillUrlTest, percentFTest, percentITest)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Main exposing (..)
import Test exposing (..)


suite : Test
suite =
    test "one plus one equals two" (\_ -> Expect.equal 2 (1 + 1))


fillUrlTest : Test
fillUrlTest =
    test "Test if fillUrl returns url(#someID)" (\_ -> Expect.equal "url(#someId)" (fillUrl "someId"))


percentFTest: Test 
percentFTest =
  test "Test Float to string with space % conversion" (\_ -> Expect.equal "50%" (percentF 50))

percentITest: Test 
percentITest =
  test "Test Int to string with space % conversion" (\_ -> Expect.equal "50%" (percentI 50))

