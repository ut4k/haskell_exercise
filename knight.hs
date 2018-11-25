-- ナイトの位置は数のペアで表現
-- ナイトがある位置から特定のマスまで移動できるかをとく

-- シノニム
type KnightPos = (Int, Int)
-- 次の位置をだす
moveKnight :: KnightPos -> [KnightPos]
moveKnight (c,r) = do
        (c', r') <- [(c+2, r-1), (c+2,r+1), (c-2,r-1), (c-2,r+1), (c+1,r-2), (c+1,r+2), (c-1,r-2), (c-1,r+2)]
        guard (c' `elem` [1..8] && r' `elem` [1..8])
        return (c', r')
