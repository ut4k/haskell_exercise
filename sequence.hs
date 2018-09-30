-- sequence関数
-- I/Oアクションのリストをうけとって順に実行する
-- sequence [getLine, getLine, getLine]
-- はgetLineして getLineして getLineするI/Oアクションをかえす


-- ***頻出
-- リストに対してI/Oアクションを返す関数をマップし、それからシーケンスにする
-- 
-- これ用の関数が２つある
-- mapMとmapM_
-- Prelude.mapM :: (Monad m, Traversable t) => (a -> m b) -> t a -> m (t b)
-- と
-- Prelude.mapM_ :: (Monad m, Foldable t) => (a -> m b) -> t a -> m ()
--
-- mapMは関数とリストを受け取って、リストに対して関数をマップして、それからシーケンスにする
-- mapM_はmapMと同じことをするが結果をすてる

--mapM_ print [1,2,3]

--これは1,2,3をそれぞれprintする
--1
--2
--3
--
--(172ページ)
