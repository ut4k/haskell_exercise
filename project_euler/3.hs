-- The prime factors of 13195 are 5, 7, 13 and 29.

-- What is the largest prime factor of the number 600851475143 ?
--
-- 13195の素因数は5,7,3,29である
-- では
-- 600851475143の最大の素因数は?
--
--
--Data.Numbers.Primesに素因数求める関数が元からあるらしい

-- factor = [x | x <- takeWhile(<= 600851475143) [1..], 600851475143 `mod` x == 0]
-- 重い...ダメ

