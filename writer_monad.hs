import Data.Monoid
import Control.Monad.Writer


--Writerモナドを学ぶ
--
-- 316ページ

-- 盗賊団が大きな盗賊団か判断する関数
-- isBigGang :: Int -> Bool
-- isBigGang x = x > 9

-- この関数が何をしたか示す文字列も一緒に返したかったら
isBigGang :: Int -> (Bool, String)
isBigGang x = (x > 9, "Compared gang size to 9.")

--では、すでに文字列がついている値をisBigGang関数に食わせたかったら?
--例えば引数(3, "Smallish gang")など

applyLog :: (a, String) -> (a -> (b, String)) -> (b, String)
applyLog (x, log) f = let (y, newLog) = f x in (y, log ++ newLog)


-- ログをStringじゃなくて任意のモノイドで受け取れるようにしてみる
-- ByteStringもリストもMonoid型クラスでどちらもmappendが実装されている
--
applyLog' :: (Monoid m) => (a, m) -> (a -> (b, m)) -> (b, m)
applyLog' (x, log) f = let (y, newLog) = f x in (y, log `mappend` newLog)

-- 319ページ
-- 食事の注文をとって、飲み物も出してくれる関数
type Food = String
type Price = Sum Int

addDrink :: Food -> (Food, Price)
addDrink "beans" = ("milk", Sum 25)
addDrink "jerky" = ("whiskey", Sum 99)
addDrink _ = ("beer", Sum 30)

-- 322ページ
-- Writerモナドをdo記法で使う

logNumber :: Int -> Writer [String] Int
logNumber x = writer (x, ["Got number: " ++ show x])

multWithLog :: Writer [String] Int
multWithLog = do
        a <- logNumber 3
        b <- logNumber 5
        tell ["Gonna multiply these two"]
        return (a*b)

-- プログラムにログを追加しよう

-- ユークリッドの互除法関数の自作(gcdはすでにある)

-- gcd' :: Int -> Int -> Int
-- gcd' a b
--    | b == 0    = a
--    | otherwise = gcd' b (a `mod` b)

--このgcd'にログ機能を加える

gcd' :: Int -> Int -> Writer [String] Int
gcd' a b
   | b == 0 = do
       tell ["Finished with " ++ show a]
       return a
   | otherwise = do
       tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
       gcd' b (a `mod` b)

--値をモナド値に変えるだけでログが取れるようになった！すげえ！


-- 最後に計算結果ログを表示する版
-- ただしこれは「++」を右結合ではなく左結合で使ってしまうので非効率!!
gcdReverse :: Int -> Int -> Writer [String] Int
gcdReverse a b
    | b == 0 = do
        tell ["Finished with " ++ show a]
        return a
    | otherwise = do
        result <- gcdReverse b (a `mod` b)
        tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
        return result

-- Finished with 1
-- 2 mod 1 = 0
-- 3 mod 2 = 1
-- 8 mod 3 = 2

----------------
-- 差分リスト
----------------
-- リストをとって別のリストを先頭に付け加える関数

--2つの差分リストを結合する
f `append` g = \xs -> f (g xs)

--327ページ
-- 差分リストのnewtypeラッパーを作る
newtype DiffList a = DiffList { getDiffList :: [a] -> [a] }

--普通のリストを差分リストにする
toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs++)

fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

-- うごかない
-- fromDiffList (toDiffList [1,2,3,4] `mappend` toDiffList [1,2,3])

-- 非効率だったgcdReverseをかきなおす

-- うごかない
-- gcdReverse' :: Int -> Int -> Writer (DiffList String) Int
-- gcdReverse' a b
--    | b == 0 = do
--        tell (toDiffList ["Finished with " ++ show a])
--        return a
--    | otherwise = do
--        result <- gcdReverse' b (a `mod` b)
--        tell (toDiffList [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)])
--        return result

--差分リストを普通のリストにする
