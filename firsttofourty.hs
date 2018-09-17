-- 問題:各桁の数の合計が40になる最初の自然数をみつける

import Data.Char
import Data.List

-- Data.Charモジュールの関数
-- :t digitToInt
-- digitToInt :: Char -> Int

-- 各桁を足し算する関数をつくる
-- 1. Intをshowする 
-- 2. showしたStringは実質リスト。リストの要素１つずつを数値に
-- 変換してmapで走査して足し算する
--
digitSum :: Int -> Int
digitSum = sum . map digitToInt . show

--たとえばdigitSum 560すれば
-- show 560 が String [560]のリストを返すので
-- 5 と 6　と 0を数値に変換してmapで走査しつつ最後に合計する
-- 5 + 6 + 0 で 11がかえる

--各桁の足し算が40になる自然数を見つける関数
--
--findはMaybe型を返す。リストのなかで条件に合致する最初の関数を返す
--digitSumした要素が40にであることがTrueになる要素をfindする!
firstTo40 :: Maybe Int
firstTo40  = find (\x -> digitSum x == 40) [1..]

-- result : Just 49999 
-- (Maybe型がかえる。もし発見できなかったらNothingになる)
