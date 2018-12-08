-- ファイルシステムのジッパーをつくる
import Data.List (break)

--値を左にかけるようになる関数
x -: f = f x

--
type Name = String
type Data = String
data FSItem = File Name Data | Folder Name [FSItem] deriving (Show)

-- これをファイルシステムとする
myDisk :: FSItem
myDisk =
    Folder "root"
        [ File "goat_yelling_like_man.wmv" "baaaaaa"
        , File "pope_time.avi" "god bless"
        , Folder "pics"
            [ File "ape_throwing_up.jpg" "bleargh"
            , File "watermelon_smash.gif" "smash!!"
            , File "skull_man(scary).bmp" "Yikes!"
            ]
        , File "dijon_poupon.doc" "best mustard"
        , Folder "programs"
            [ File "fartwizard.exe" "10gotofart"
            , File "owl_bandit.dmg" "move eax, hoot"
            , File "not_a_virus.exe" "really not a virus"
            , Folder "source code"
                [ File "best_hs_prog.hs" "main = print (fix error)"
                , File "random.hs" "main = print 4"
                ]
            ]
        ]

--パンくず
data FSCrumb = FSCrumb Name [FSItem] [FSItem] deriving (Show)

--ジッパー
type FSZipper = (FSItem, [FSCrumb])

-- 上に戻る
fsUp :: FSZipper -> FSZipper
fsUp (item, FSCrumb name ls rs:bs) =
        (Folder name (ls ++ [item] ++ rs), bs)

fsTo :: Name -> FSZipper -> FSZipper
fsTo name (Folder folderName items, bs) =
        let (ls, item:rs) = break (nameIs name) items
        in  (item, FSCrumb folderName ls rs:bs)

nameIs :: Name -> FSItem -> Bool
nameIs name (Folder folderName _) = name == folderName
nameIs name (File fileName _) = name == fileName

--リネーム
fsRename :: Name -> FSZipper -> FSZipper
fsRename newName (Folder name items, bs) = (Folder newName items, bs)
fsRename newName (File name dat, bs) = (File newName dat, bs)

-- 新規ファイル作成
fsNewFile :: FSItem -> FSZipper -> FSZipper
fsNewFile item (Folder folderName items, bs) =
        (Folder folderName (item:items), bs)
