import Test.QuickCheck

squared :: Int -> Int
squared i = i * i

sum_of_first_few_odd_ints :: Int -> Int
sum_of_first_few_odd_ints i = sum $ take i $ filter odd [1..]

main :: IO ()
main = verboseCheck (\i -> i >= 1 ==> squared i == sum_of_first_few_odd_ints i)
-- main = quickCheckWith stdArgs
--                       { maxSuccess = 10000 }
--                       ( \i -> i >= 1 ==> squared i == sum_of_first_few_odd_ints i )

-- main = quickCheck (\i -> i >= 1 ==> squared i == sum_of_first_few_odd_ints i)
