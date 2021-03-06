-- If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
-- Find the sum of all the multiples of 3 or 5 below 1000.

-- 3または5の倍数である10未満の自然数をすべて列挙すると、
-- 3,5,6,9が得られます。これらの倍数の合計は23です。
--
-- 1000以下の3または5の倍数の合計を求めなさい。
-- * "below"は以下じゃなくて"未満"らしい

-- 1000未満の数のリストから3または5の倍数である条件がtrueのものをリストで返して
-- 返ったリストを左畳み込みで+関数を適用していって全部出す、
-- 最後に＄よりも右の計算けっかをprintして答えを出力

findMult :: [Int]
findMult = [ x | x <- [1..(1000-1)], x `mod` 3 == 0 || x `mod` 5 == 0 ]
main = do
        print $ foldl (+) 0 (findMult)
