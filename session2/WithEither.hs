import Data.List

times_three_plus_twenty_one :: Int -> Int
times_three_plus_twenty_one = (+21) . (*3)

check_if_even :: Int -> Either String Int
check_if_even x =
  if
    even x
  then
    Right x
  else
    Left $ "ERROR: " ++ show x ++ " is not an even number."

check_if_between_10_and_50 :: Int -> Either String Int
check_if_between_10_and_50 n =
  maybe ( Left $ "ERROR: " ++ show n ++ " is not between 10 and 50." )
        ( Right )
        ( find (==n) [10..50] )

check_if_between_10_and_90 :: Int -> Either String Int
check_if_between_10_and_90 n =
  maybe ( Left $ "ERROR: " ++ show n ++ " is not between 10 and 90." )
        ( Right )
        ( find (==n) [10..90] )

check_result :: Int -> Either String Int
check_result n =
  Right n
    >>= check_if_between_10_and_50
      >>= check_if_even
        >>= (check_if_between_10_and_90 . times_three_plus_twenty_one)

main :: IO ()
main = mapM_ print . map check_result $ [10..60]

-- Right 51
-- Left "ERROR: 11 is not an even number."
-- Right 57
-- Left "ERROR: 13 is not an even number."
-- Right 63
-- Left "ERROR: 15 is not an even number."
-- Right 69
-- Left "ERROR: 17 is not an even number."
-- Right 75
-- Left "ERROR: 19 is not an even number."
-- Right 81
-- Left "ERROR: 21 is not an even number."
-- Right 87
-- Left "ERROR: 23 is not an even number."
-- Left "ERROR: 93 is not between 10 and 90."
-- Left "ERROR: 25 is not an even number."
-- Left "ERROR: 99 is not between 10 and 90."
-- Left "ERROR: 27 is not an even number."
-- Left "ERROR: 105 is not between 10 and 90."
-- Left "ERROR: 29 is not an even number."
-- Left "ERROR: 111 is not between 10 and 90."
-- Left "ERROR: 31 is not an even number."
-- Left "ERROR: 117 is not between 10 and 90."
-- Left "ERROR: 33 is not an even number."
-- Left "ERROR: 123 is not between 10 and 90."
-- Left "ERROR: 35 is not an even number."
-- Left "ERROR: 129 is not between 10 and 90."
-- Left "ERROR: 37 is not an even number."
-- Left "ERROR: 135 is not between 10 and 90."
-- Left "ERROR: 39 is not an even number."
-- Left "ERROR: 141 is not between 10 and 90."
-- Left "ERROR: 41 is not an even number."
-- Left "ERROR: 147 is not between 10 and 90."
-- Left "ERROR: 43 is not an even number."
-- Left "ERROR: 153 is not between 10 and 90."
-- Left "ERROR: 45 is not an even number."
-- Left "ERROR: 159 is not between 10 and 90."
-- Left "ERROR: 47 is not an even number."
-- Left "ERROR: 165 is not between 10 and 90."
-- Left "ERROR: 49 is not an even number."
-- Left "ERROR: 171 is not between 10 and 90."
-- Left "ERROR: 51 is not between 10 and 50."
-- Left "ERROR: 52 is not between 10 and 50."
-- Left "ERROR: 53 is not between 10 and 50."
-- Left "ERROR: 54 is not between 10 and 50."
-- Left "ERROR: 55 is not between 10 and 50."
-- Left "ERROR: 56 is not between 10 and 50."
-- Left "ERROR: 57 is not between 10 and 50."
-- Left "ERROR: 58 is not between 10 and 50."
-- Left "ERROR: 59 is not between 10 and 50."
-- Left "ERROR: 60 is not between 10 and 50."
