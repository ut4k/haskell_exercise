--状態付き計算
import Control.Monad.State
import System.Random
--
-- スタックを表現する
--
type Stack = [Int]

--pop リストの頭と、取り除いたあとのリストも返す
-- pop :: Stack -> (Int, Stack)
-- pop (x:xs) = (x, xs)

--push ある要素をリストの頭に積む、積んだあとのリストも返す
-- push :: Int -> Stack -> ((), Stack)
-- push a xs = ((), a:xs)

-- スタックをシミュレートするコード
-- これは状態付き計算
-- stackManip :: Stack -> (Int, Stack)
-- stackManip stack = let
--     ((), newStack1) = push 3 stack
--     (a, newStack2) = pop newStack1
--     in pop newStack2

------------------------------------------------------------------------
-- Stateモナドを使うと、状態付き計算を、状態に手を触れる必要もなく扱える!!

pop :: State Stack Int
pop = state $ \(x:xs) -> (x, xs) 

push :: Int -> State Stack ()
push a = state $ \xs -> ((), a:xs)

stackManip :: State Stack Int
stackManip = do
        push 3
        a <- pop
        pop

-- runState stackManip [1,3,4]
-- (1,[3,4])

stackStuff :: State Stack ()
stackStuff = do
        a <- pop
        if a == 5
            then push 5
            else do
                push 3
                push 8

moreStack :: State Stack ()
moreStack = do
        a <- stackManip
        if a == 100
            then stackStuff
            else return ()
            
-- MonadState型クラスのgetとputを使ってみる

stackyStack :: State Stack ()
stackyStack = do
        stackNow <- get
        if stackNow == [1,2,3]
            then put [8,3,1]
            else put [9,2,1]

-- getとputをつかってpopとpushが実装できる
-- うごかない???
--
-- pop' :: State Stack Int
-- pop' = do
--         (x:xs) <- get
--         put xs
--         return x

-- push' :: Int -> State Stack ()
-- push' x = do
--         xs <- get
--         put (x:xs)
--
-----------------------
--ランダム処理を楽にする
-----------------------
randomSt :: (RandomGen g, Random a) => Stage g a
randomSt = state random

-- コインを3枚投げる
-- 状態付き関数に!
threeCoins :: State StdGen (Bool, Bool, Bool)
threeCoins = do
        a <- randomSt
        b <- randomSt
        c <- randomSt
        return (a, b, c)
