-- モナドとしての関数
-- import Control.Monad.Instances --非推奨になったらしい

-- addStuff :: Int -> Int
-- addStuff = do
--         a <- (*2)
--         b <- (+10)
--         return (a+b)

addStuff :: Int -> Int
addStuff x = let
        a = (*2) x
        b = (+10) x
        in a+b

