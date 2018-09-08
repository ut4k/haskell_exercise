-- my very first haskell code!!

-- これが関数のかたまり
-- fizzBuzz関数はIntegerをうけとってStringを返す
fizzBuzz :: Integer -> String
fizzBuzz number
  | fizz = "Fizz!"
  | buzz = "Buzz!"
  -- show関数はIntegerを文字列で表現してくれる!!
  | otherwise = show number
  -- whereキーワードでfizzとbuzzを返す。ガードに渡すために必ずBoolで。
  where fizz = number `mod` 3 == 0
        buzz = number `mod` 5 == 0

-- メイン
main =
  -- コピペ
  -- fizzBuzzをリストにマップして出力できる型にしてる？謎
  mapM_ putStrLn $ map fizzBuzz [1..50]
