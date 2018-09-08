quicksort [] = []
quicksort (x:xs) =
  quicksort lt ++ [x] ++ quicksort gtoreq
  where
    lt = [y | y <- xs, y < x]
    gtoreq = [ y | y <- xs, y >= x]

-- quicksort [10,34,5,67,4,3,2,199,45,1,0,23]
-- result:
-- [0,1,2,3,4,5,10,23,34,45,67,199]


