--アプリカティブファンクターをつかってみる
fnc1 = Just (+3) <*> Just 9
-- Just 12
fnc2 = pure (+3) <*> Just 10
-- Just 13
fnc3 = pure (+3) <*> Just 10
-- Just 13
fnc4 = Just (++"hahah") <*> Nothing
-- Nothing
fnc5 = Nothing <*> Just "woot"
-- Nothing

-- <*>を連続して使う
fnc6 = pure (+) <*> Just 3 <*> Just 5
-- <*>は左結合である!
--　...つまりこうとも書ける
fnc6' = (pure (+) <*> Just 3) <*> Just 5
-- Just 8
fnc7 = pure (+) <*> Just 3 <*> Nothing
-- Nothing
fnc8 = pure (+) <*> Nothing <*> Just 5
-- Nothing

-- 2つの関数を２つのリストに適用する
fnc9 = [(+),(*)]  <*> [1,2] <*> [3,4]
-- [4,5,5,6,3,4,6,8]

-- くりかえすが<*>は左結合なので左から計算!!!!
-- [(+),(*)]  <*> [1,2]が先

-- 内包表記もアプリカティブスタイルで書き換えられたりする
fnc10 = [x*y |  x <- [2,5,10], y <- [8,10,11]]
-- 2つのリストの積を全部だしたいとき
-- アプリカティブでやると
fnc10' = (*) <$> [2,5,10] <*> [8,10,11]

