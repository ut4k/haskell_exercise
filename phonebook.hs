import qualified Data.Map as Map
import Data.Char

--------------------------------------
--Data.Mapモジュールであそぶ
--------------------------------------

-- fromList関数は順序比較が必要なのでOrd型クラスのキーと、連想リストの値を取る
-- Map.fromList :: Ord k => [(k, a)] -> Map.Map k a

-- Mapモジュール（自分で命名）のMap関数が引数1にString、引数2にStringを取るということ　たぶん
phoneBook :: Map.Map String String
phoneBook = Map.fromList $
    [("betty","555-2938")
    ,("bonnie","452-2928")
    ,("patsy","493-2928")
    ]

--これをMap.lookup 名前 フォンブック連想リストでメイビー型を返す形で探せる
--あればJustなければNothing

-- Map.insert :: Ord k => k -> a -> Map.Map k a -> Map.Map k a
-- Map.insert "キー" "値" リスト
-- リストにキーと値をいれてリストをかえす

-- Map.size :: Map.Map k a -> Int
-- Map.size リスト
-- リストのサイズを返す

--------------------------------------------------------------------
-- 電話番号をIntのリストで持ちたいとき

-- Stringの電話番号をIntのリストにする関数
-- 復習:filterは「述語」（Boolを返す関数)を受け取ってtrueになるものだけかえす
-- （内包表記の書き方違い版）
-- filter p xs = [ x | x <- xs, p x]
-- ハイフンは数字じゃないのでフィルタリングのときに消える

-- digitToIntと(filter isDigit)を合成した関数をStringにマップする(?)
string2digits :: String -> [Int]
string2digits = map digitToInt . filter isDigit



