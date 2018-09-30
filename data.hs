data Shape = Circle Float Float Float |
             Rectangle Float Float Float Float

-- CircleとRectangleはShapeデータの「値コンストラクタ」
-- 「値コンストラクタ」も実はそのデータ型を返す関数

area :: Shape -> Float
area (Circle _ _ r) = pi * r ^ 2
area (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)

-------------------------------

--NG例
-- data Person = Pereson String String Int Float String String
--               deriving (Show)
--
-- 人物からfirstNameをとりだすとき
-- firstName :: Person -> String
-- firstName (Preson firstname _ _ _ _ _) = firstname
-- これは書いていられない・・・

-- レコード構文
data Person = Person { firstName :: String
                      , lastName :: String
                      , age :: Int
                      , height :: Float
                      , phoneNumber :: String
                      , flavor :: String } deriving (Show)

-- 型シノニム 名前つけてわかりやすくする仕組みみたいなもの
-- ただのStringじゃなくてNameと呼んだら見たとき意味がわかりやすい
type PhoneNumber = String
type Name = String
type PhoneBook = [(Name ,PhoneNumber)]
