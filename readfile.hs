import System.IO

main = do
        handle <- openFile "baabaa.txt" ReadMode
        contents <- hGetContents handle
        putStr contents
        hClose handle
       
--withFile関数でかく
--
--withFileはファイル操作中に例外がおきても正しくファイルを閉じてくれる
--ハンドルを自分で閉じなくてもいい
--
-- main = do
--         withFile "baabaa.txt" ReadMode $ \handle -> do
--             contents <- hGetContents handle
--             putStr contents
