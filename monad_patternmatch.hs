justH :: Maybe Char
justH = do
        (x:xs) <- Just "hello"
        return x

-- Just 'h'

wopwop :: Maybe Char
wopwop = do
        (x:xs) <- Just ""
        return x

-- Nothing
