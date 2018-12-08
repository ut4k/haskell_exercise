--逆ポーランド記法電卓 エラー処理つきバージョン
import Control.Monad
import Data.List

readMaybe :: (Read a) => String -> Maybe a
readMaybe st = case reads st of [(x, "")] -> Just x
                                _ -> Nothing
foldingFunction :: [Double] -> String -> Maybe [Double]
foldingFunction (x:y:ys) "*" = return ((y * x):ys)
foldingFunction (x:y:ys) "+" = return ((y + x):ys)
foldingFunction (x:y:ys) "-" = return ((y - x):ys)
foldingFunction xs numberString = liftM (:xs) (readMaybe numberString)

solveRPN :: String -> Maybe Double
solveRPN st = do
        [result] <- foldM foldingFunction [] (words st)
        return result

