-- 型シノニム
type Birds = Int
type Pole = (Birds, Birds)

-- 鳥が止まる関数
-- 左に止まる
landLeft :: Birds -> Pole -> Pole
landLeft n (left, right) = (left + n, right)

-- 右に止まる
landRight :: Birds -> Pole -> Pole
landRight n (left, right) = (left, right + n)

-- 引数を先に書いてその後に関数fをかける関数を作ってみる↓
-- これで書くと鳥を止まらせる関数が読みやすくなる
x -: f = f x

-- (0, 0) -: landLeft 1 -: landRight 4 -: landLeft (-1) -: landRight (-2)
-- これだと(0, 4)の瞬間に落ちてる!!
-- 失敗を表現したいので関数をなおす

landLeft' :: Birds -> Pole -> Maybe Pole
landLeft' n (left, right)
    | abs ((left + n) - right) < 4 = Just (left + n, right)
    | otherwise                    = Nothing

landRight' :: Birds -> Pole -> Maybe Pole
landRight' n (left, right)
    | abs (left - (right + n)) < 4 = Just (left, right + n)
    | otherwise                    = Nothing

--バナナで綱から落っことす関数
banana :: Pole -> Maybe Pole
banana _ = Nothing

-- >>関数は規定のモナド値を返す関数
--
--これうごかない!!!
fnc = return (0, 0) >>= landLeft' 1 >> Nothing >>= landRight' 1

--------------------------------
-- do記法で書いてみる

routine :: Maybe Pole
routine = do
    start <- return (0, 0)
    first <- landLeft' 2 start
    second <- landRight' 2 first
    landLeft' 1 second
