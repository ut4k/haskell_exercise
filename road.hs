-- 道路網をhaskellで表現する
data Section = Section { getA :: Int, getB :: Int, getC :: Int }
             deriving (Show)

type RoadSystem = [Section]

--ヒースロー空港からロンドンまで
heathrowToLondon :: RoadSystem
heathrowToLondon = [ Section 50 10 30
                   , Section 5 90 20
                   , Section 40 2 25
                   , Section 10 8 0
                   ]

data Label = A | B | C deriving (Show)
type Path = [(Label, Int)]


roadStep :: (Path, Path) -> Section -> (Path, Path)
roadStep (pathA, pathB) (Section a b c) =
        let timeA = sum (map snd pathA)
            timeB = sum (map snd pathB)
            forwardTimeToA = timeA + a
            crossTimeToA = timeB + b + c
            forwardTimeToB = timeB + b
            crossTimeToB = timeA + a + c
            newPathToA = if forwardTimeToA <= crossTimeToA
                            then (A, a) :pathA
                            else (C, c) : (B, b) :pathB
            newPathToB = if forwardTimeToB <= crossTimeToB
                            then (B, b) :pathB
                            else (C. c) : (A, a) :pathA
        in (newPathToA, newPathToB)

optimalPath :: RoadSystem -> Path
optimalPath roadSystem =
        let (bestAPath, bestBpath) = foldl roadStep ([], []) roadSystem
        in if sum (map snd bestApath) <= sum (map snd bestBPath)
              then reverse bestAPath
              else reverse bestBpath

--うごかない!!


