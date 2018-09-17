-- 連想リストからキーで値を探す

-- haskellのハッシュテーブル?はペアのリスト
phoneBook = [("betty","555-2938")
            ,("bonnie","452-2928")
            ,("patsy","493-2928-2928")
            ]

-- キー　と　連想リスト　を引数にとり、
-- うまくいけば値を返す
-- 空リストならNothing
findKey :: (Eq k) => k -> [(k, v)] -> Maybe v
findKey key [] = Nothing
-- リストからヘッド部の(キー、値)ペアを取り出して、
-- 引数のキーと合えば値を返す
-- それ以外は再帰する
findKey key ((k,v):xs)
    | key == k = Just v
    | otherwise = findKey key xs

-- 畳み込みで実装
-- 型宣言はおなじ
findKey' :: (Eq k) => k -> [(k,v)] -> Maybe v
-- 右畳み込みで
-- アキュムレータは無名関数：ペアのキーが引数とマッチすれば値を返す。
-- それいがいはアキュムレータを返す
-- アキュムレータの初期値はNothing
-- 畳み込んだリストを返す
-- ???
findKey' key xs = foldr
                  (\(k, v) acc -> if key == k then Just v else acc)
                  Nothing xs
