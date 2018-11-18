foo :: Maybe String
foo = Just 3 >>= (\x ->
      Just "!" >>= (\y ->
      Just (show x ++ y)))

-- do記法で書き直すと...
foo' :: Maybe String
foo' = do
        x <- Just 3
        y <- Just "!"
        Just (show x ++ y)

-------------

fnc = Just 9 >>= (\x -> Just (x > 8))

marySue :: Maybe Bool
marySue = do
        x <- Just 9
        Just (x > 8)
