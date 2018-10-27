-- ファンクターとは関数を使って写せるものの概念らしい
import Data.Either
--
myf = fmap  (*2) (Just 4)
-- 結果:Just 8というファンクターを返す

-- Maybeファンクターの箱にはいった4という値に(*2)関数を適用して、Maybeファクターの箱にはいった8を返すという考え
-- たぶん。
--
-- <$>でもかける
myf' = (*2) <$> (Just 4)
--
-- リストもMaybeもEitherもStringもファンクターであるからfmapの第二引数に使える
myf2 = fmap  (*2) [2,3,4,5]
-- 結果:[4,6,8,10]というファンクター(リスト)を返す

myf3 = fmap  (++"world") (Right "hello,")
-- 結果:Right "hello,world"というファンクター(Either)を返す

-- TODO
-- myf4 = fmap compare "ここがStringの場合???"

