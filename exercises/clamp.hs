-- Limit output to a range of numbers

clamp :: (Eq a, Ord a) => a -> (a, a) -> a
clamp x r
    | x > (snd r) = snd r
    | x < (fst r) = fst r
    | otherwise = x

main :: IO()
main = do
  putStrLn $ show $ clamp 5 (10, 20)
  putStrLn $ show $ clamp 15 (10, 20)
  putStrLn $ show $ clamp 22 (10, 20)