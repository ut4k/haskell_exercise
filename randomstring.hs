import System.Random

main = do 
          gen <- getStdGen
          putStrLn $ take 20 (randomRs ('a','z') gen)
           --2回目も同じ文字列
          gen2 <- getStdGen
          putStrLn $ take 20 (randomRs ('a','z') gen2)
          gen' <- newStdGen
          putStrLn $ take 20 (randomRs ('a','z') gen')
