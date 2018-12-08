fnc1 = Left "boom" >>= \x -> return (x + 1)
fnc2 = Left "boom " >>= \x -> Left "no way!"
fnc3 = Right 100 >>= \x -> Left "no way!"
