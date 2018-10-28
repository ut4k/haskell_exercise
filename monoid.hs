-- =======================-
--リストはモノイド!
-- =======================-
--appendって覚えないこと！２つのモノイド値をとって第３の値を返すと覚える！！
--
fnc1 = [1,2,3] `mappend` [4,5,6]
fnc2 = ("one" `mappend` "two") `mappend` "tree"
fnc3 = "one" `mappend` "two" `mappend` "three"

-- =======================-
--オーダリングはモノイド!
-- =======================-

fnc4 = LT `mappend` GT
fnc5 = GT `mappend` LT
fnc6 = mempty `mappend` LT
fnc7 = mempty `mappend` GT

--文字の長さ比較を普通に書く
lengthCompare :: String -> String -> Ordering
lengthCompare x y = let a = length x `compare` length y
                        b = x `compare` y
                    in  if a == EQ then b else a

--モノイドの知識を取り入れてかくと
lengthCompare' :: String -> String -> Ordering
lengthCompare' x y = (length x `compare` length y) `mappend`
                    (x `compare` y)

-- =======================-
--メイビーはモノイド!
-- =======================-
fnc8 = Nothing `mappend` Just "andy"
fnc9 = Just LT `mappend` Nothing
