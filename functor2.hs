-- ファンクターの法則を破る例
data CMaybe a = CNothing | CJust Int a deriving (Show)

--このCMaybeをファンクターのインスタンスにしてみる
instance Functor CMaybe where
        fmap f CNothing = CNothing
        fmap f (CJust counter x) = CJust (counter+1) (f x)
 
-- idでファクター値を写した結果　と　idをファンクター値に適用した結果は同じでなければならない
-- fmap id (CJust 0 "haha")
--  結果: Cjust 1 "haha"
-- id (CJust 0 "haha")
--  結果: CJust 0 "haha"

--ファンクター則を満たしていないのにファンクターのインスタンスだとうたっている
--CMaybeをコードの中で利用するのは危険

--ファンクターのインスタンスにしようと思ったらその実装がファンクター則を満たしているか必ず確認しないといけない

