import Data.List

times_three_plus_twenty_one :: Int -> Int
times_three_plus_twenty_one = (+21) . (*3)

check_if_even :: Int -> Maybe Int
check_if_even x =
  if
    even x
  then
    Just x
  else
    Nothing

check_if_between_10_and_50 :: Int -> Maybe Int
check_if_between_10_and_50 n = find (==n) [10..50]

check_if_between_10_and_90 :: Int -> Maybe Int
check_if_between_10_and_90 n = find (==n) [10..90]

check_result :: Int -> Maybe Int
check_result n =
  Just n
    >>= check_if_between_10_and_50
      >>= check_if_even
        >>= (check_if_between_10_and_90 . times_three_plus_twenty_one)

main :: IO ()
main = mapM_ print . map check_result $ [10..60]

-- Just 51
-- Nothing
-- Just 57
-- Nothing
-- Just 63
-- Nothing
-- Just 69
-- Nothing
-- Just 75
-- Nothing
-- Just 81
-- Nothing
-- Just 87
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
-- Nothing
