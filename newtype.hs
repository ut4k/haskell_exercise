-- ダメな例
-- data CoolBool = CoolBool{ getCoolBool :: Bool }
-- OKな例 ---> とおもったらこれも動かない 263ページ ???
-- newtype CoolBool = CoolBool{ getCoolBool :: Bool }

helloMe :: CoolBool -> String
helloMe (CoolBool _) = "hello"

-- エクセプション!
fnc1 = helloMe undefined
