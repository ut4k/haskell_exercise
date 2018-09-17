-----------------------------------------------------
-- 関数定義の基本
-- 関数名 引数 = 式
-----------------------------------------------------
doubleMe x = x + x
doubleUs x y = x * 2 + y * 2
doubleSmallNumber x = if x > 100 then x else x*2

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- factorial :: Integer -> Integer
-- factorial n  = product [1..n]

-----------------------------------------------------
-- 関数定義(型宣言つき)
-- 一行目 : 型宣言
-- 二行目 : 関数定義
-----------------------------------------------------
circumference :: Float -> Float
circumference r = 2 * pi * r

circumference' :: Double -> Double
circumference' r = 2 * pi * r

-----------------------------------------------------
-- パターンマッチ
-- 引数があるパターンにマッチしたらそれを実行
-- 上から順でマッチを見ていく
-- 手続き型のif elseで引数を見ていくような・・・
-----------------------------------------------------

lucky :: Int -> String
lucky 7 = "lucky number seven!"
lucky x = "sorry, you're out of luck, pal!"

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors a b = (fst a + fst b, snd a + snd b)
-- addVectors :: (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

firt :: (a, b, c) -> a
firt (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

head' :: [a] -> a
head' [] = error "can't call head on an empty list!"
-- リストの先頭要素をxに束縛し、残りのリストを_に束縛する
-- このとき複数の変数の束縛が怒っているので、丸括弧で囲んでいる
-- [1..5]をわたせばリスト先頭の1がかえり、_変数には残りの[2,3,4,5]が束縛されていて、これは捨ててるということ
head' (x:_) = x

-- bmiTell :: Double -> Double -> String
-- bmiTell weight height
--     | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
--     | weight / height ^ 2 <= 25.0 = "You're supposedly normal.\
--                                    \ Pffft, I be you're ugly!"
--     | weight / height ^ 2 <= 30.0 = "You're fat!"
--     | otherwise = "You're a whale, congratulations!"
--

-----------------------------------------------------
-- ガード
-- if elseより可読性が高い？
-- ガードの|の前のスペースは４つがいい、らしい
-- 一つもマッチせずしかもotherwiseもなければエラー
-----------------------------------------------------

max' :: (Ord a) => a -> a -> a
max' a b
    | a <= b = b
    | otherwise = a


-- bmiTell :: Double -> Double -> String
-- bmiTell weight height
--     | bmi <= 18.5 = "You're underweight, you emo, you!"
--     | bmi <= 25.0 = "You're supposedly normal.\
--                                    \ Pffft, I be you're ugly!"
--     | bmi <= 30.0 = "You're fat!"
--     | otherwise = "You're a whale, congratulations!"
--     where bmi = weight / height ^ 2 
--

-----------------------------------------------------
-- where
-- 関数の後ろで計算結果を保持しておけるもの
-- 何度も何度も計算式をかかなくてもこれをつかえばいい
-----------------------------------------------------

bmiTell :: Double -> Double -> String
bmiTell weight height
    | bmi <= skinny = "You're underweight, you emo, you!"
    | bmi <= normal = "You're supposedly normal.\
                                   \ Pffft, I be you're ugly!"
    | bmi <= fat = "You're fat!"
    | otherwise = "You're a whale, congratulations!"
    where bmi = weight / height ^ 2 
          skinny = 18.5
          normal = 25.0
          fat = 30.0

initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = firstname
          (l:_) = lastname

-----------------------------------------------------
-- let in
-- 構文
-- let bindings in expression
-- 代入applyじゃなく束縛bind!!
-----------------------------------------------------

cylinder :: Double -> Double -> Double
cylinder r h =
    let sideArea = 2 * pi * r * h
        topArea  = pi * r ^ 2
    in sideArea + 2 * topArea

calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi > 25.0]

-----------------------------------------------------
-- 再帰
-- recursion
-- 関数のなかで自分を呼ぶ
-----------------------------------------------------

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

repeat' :: a -> [a]
repeat' x = x : repeat' x

zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys

quicksort :: (Ord a) => [a] -> [a]
-- quicksort :: [a] -> [a] --これは型クラスを宣言してないから動かない --なんで？
quicksort [] = []
quicksort (x:xs) =
    let smallerOrEqual = [a | a <- xs, a <= x]
        larger = [a | a <- xs, a > x]
    in quicksort smallerOrEqual ++ [x] ++ quicksort larger

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x

quicksort' :: (Ord a) => [a] -> [a]
quicksort' [] = []
quicksort' (x:xs) =
    let smallerOrEqual = filter (<= x) xs
        larger = filter (> x) xs
    in quicksort' smallerOrEqual ++ [x] ++ quicksort' larger

largestDivisible :: Integer
largestDivisible = head (filter p [100000, 99999])
 where  p x = x `mod` 3829 == 0

-----------------------------------------------------
-- 高階関数、カリー化
-- higher order function, currying
-- 高階関数 : 引数に関数があったり、返り値に関数があったりする関数らしい
--            代表的なのがmap,filterとか
--            リストの要素１つ１つにある関数を適用するような関数のことだとおもう
-- カリー化 : 食べ物のカレーのcurry
--            複数の引数を受け取る代わりに１つの引数をとって関数を返すらしい
--            なんに使うか不明...
--            jsにもこの概念が使えるらしい
-----------------------------------------------------

-- Intを３つ受け取ってIntをかえす
multThree :: Int -> Int -> Int -> Int
multThree x y z = x * y * z

-- 引数1 : 1つ引数をとり、同じ型の値を返す関数
-- 引数2 : なにかa型の値
applyTwice :: (a -> a) -> a -> a
-- functionとxをとって、functionを適用したxに再度functionを適用してる
applyTwice f x = f (f x)
-- 使用 : applyTwice (+3) 10
--        10に+3関数を２回適用する

-- ビルドインのzipWithを再作成する
-- 関数と,[a]というリストと[b]というリストをうけとって[c]というリストを返す
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

--クイックソートフィルターバージョン
--Ord型のリスト[a]をうけとりリスト[a]をかえす
--パターンマッチその１ 空なら空リストをかえす
--パターンマッチその2 リストならソートしてかえす
--小なりイコール ... ピボットと同じかそれよりちいさい残り部分
--大なり ... ピボットより大きい残り部分
-- 小なりイコールと大なりの両方のリストにクイックソートをかける(再帰)
-- うごかない...
--
-- quicksortf [3,3,414,13123,414,5,6]
-- *** Exception: baby.hs:159:1-18: Non-exhaustive patterns in function quicksortf

quicksort'' :: (Ord a) => [a] -> [a]
quicksort'' [] = []
qiucksort'' (x:xs) =
    let smallerOrEqual = filter (<= x) xs
        larger = filter (> x) xs
    in  quicksort'' smallerOrEqual ++ [x] ++ quicksort'' larger

-----------------------------------------------------
-- ラムダ式
-- lambda
-- 高階関数に渡すために一回だけ使う無名関数のこと
-- \ナントカ
-- \　これが λ に見えるからラムダらしい
-----------------------------------------------------

-- 下２つは同じ
-- xに３を足す関数をリスト１，６，３，２の要素にそれぞれマップしてる
-- xに３を足す関数をラムダ式で書いたのが下
-- map (+3) [1,6,3,2]
-- map (\x -> x +3) [1,6,3,2]-

-- flipをラムダ式でかく
-- flip' :: (a -> b -> c) -> b -> a -> c
-- flip' f = \x y -> f y x

-- ２つの数を足し算するmyaddをラムダ式で書く
-- myadd :: Int -> Int -> Int
-- myadd x y = x + y

-- "2つの引数を足し算する無名関数" を生成する関数 myaddになる
myadd :: Int -> Int -> Int
myadd = (\x y -> x + y)

-----------------------------------------------------
-- 畳み込み
-- fold
-- リストを走査してそれに基づいた結果を返すときに使えるらしい
--
-- 畳み込み関数は
-- 「２つの引数を取る関数」と
-- 畳込みに用いる値「アキュムレータ」と
-- 畳み込むリスト
-- を受け取る
--
-- 代表的:
--  foldl
--  foldr
--  foldl1 (リストのヘッドをアキュムレータの初期値に使う版)
--  foldr1 (リストのヘッドをアキュムレータの初期値に使う版)
--  scanl
--  scanr
-----------------------------------------------------
--
-- 畳み込みでsum
-- (foldl, left fold 左畳み込みをつかう)
--
-- (\acc x -> acc + x)が「２つの引数を取る関数」しかもここでは無名関数
-- 0がアキュムレータの初期値
--  アキュムレータの型は結果の型と同じ
-- xsは畳み込みたいリスト
--
-- リストxsを受け取ってるのに先頭要素xはどっから来た ???
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

-- 実は関数がカリー化されてるので下のようにできる
-- sum' :: (Num a) => [a] -> a
-- sum' = foldl (+) 0

--畳み込みで実装
--リスト反転
--元のリストを左から順にアキュムレーターの空リストの先頭にくっつけていくから逆順になる
reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x: acc) []
--積を求める
-- リストの各要素をアキュムレータに掛け合わせていく(最初は×１)
product' :: (Num a) => [a] -> a
product' = foldl (*) 1
--フィルタリング
--filter
--述語（TrueかFalseを返す関数p）がTrueならリストに追加、そうでなければアキュムレータをそのまま使う
--これで一致するものだけが追加される
filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x : acc else acc) []
--最後の要素取得last
--リストを最初から見ていってアキュムレータを毎回要素に置き換える
--これで最後には末尾の要素がアキュムレータになって帰るというわけ
last' :: [a] -> a
last' = fold1 (\_ x -> x)


