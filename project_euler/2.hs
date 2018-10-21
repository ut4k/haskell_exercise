-- Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

-- 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

-- By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.


--フィボナッチ数列が400万を越えないものとして考えて
--偶数項の和を求めよ
--
-- takeWhile (真偽を返す関数) リスト

problem_2 = sum [ x | x <- takeWhile (<= 4000000) fibs, even x]
  where
    fibs = 0 : 1 : zipWith (+) fibs (tail fibs)


-- 参考:
-- fibs
-- https://www.slideshare.net/chiguri/fibonacci-41159109
-- fibsは0番目は0、1番目は1と続いて、残りはfibsと fibsの一つ後ろの列を足し算で合わせた残り
-- 
--
--
-- 例えばghciに 0 : 1 : [1..10] とうつと
--[0,1,1,2,3,4,5,6,7,8,9,10]となる。
--
--それみたいなもんで 0 と 1　と fibs
--と fibsの最後尾をzipWithしたものをリストにする
--
--
--
-- ...ちなみにzipWithは結合に使う関数で２つのリストを１つに合わせる
-- 例:
-- zipWith (+) [3,2,6] [5,17,9]
-- [8,19,15]
-- (+)関数で左のリストと右のリストを結合してる
--
-- fibsリストは再帰的にどんどんリストができていくように見えるが、zipWithした部分の「サンク」はあとで評価されるから壊れない　らしい
--
-- 参考gif:
-- https://twitter.com/fumieval/status/529973251875688448
