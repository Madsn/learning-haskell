import Data.List (sort)
import Test.QuickCheck


clampA :: Int -> Int -> Int -> Int
clampA minBound maxBound x = (!! 1) . sort $ [minBound,maxBound,x]

clampB :: Int -> Int -> Int -> Int
clampB minBound maxBound x
    | x > maxBound = maxBound
    | x < minBound = minBound
    | otherwise = x

main = quickCheck (\i j k -> i < j ==> clampA i j k == clampB i j k)

--main = quickCheck (\i -> \j -> \k -> clampA i j k == clampB i j k)
  -- conclusion: they are not in fact equivalent, when given conflicting min/max bound values (precedence differs)
