-- 整数 <=> Integer
-- 有理数 <=> Rational
-- 2 つの元の集合 {0, 1} <=> Bool
-- 意味を一致させておくことが大事

-- instance Show Integer where
   -- ここで Show の実装 

-- 【カリー＝ハワード同型】

-- 型 <=> 命題
-- ロジック <=> 証明

-- ( 命題の主張 )
-- associativeLaw :: Semigroup a => a -> a -> a -> Bool
-- 任意の半群 a についてのある元 a が 3 つあるならば真偽が定まる

-- ( 命題の証明 )
-- associativeLaw x y z = ...
-- ... なので命題は正しい

-- 半群 = 足し合わせることができる構造
-- 半群 (semigroup) は集合 S とその上の結合的二項演算とをあわせて考えた代数的構造である。

import Prelude hiding (concat)

class Semigroup a where
  (<>) :: a -> a -> a

-- 結合法則
associativeLaw :: (Semigroup a, Eq a) => a -> a -> a -> Bool
associativeLaw x y z = (x <> y) <> z == x <> (y <> z)

-- 二項演算 ( a -> b -> c )

-- 『上の』＝『に閉じている』
-- + は Integer 上の演算
-- + は Integer について閉じている

instance Semigroup Integer where
  (<>) = (+)

instance Semigroup Bool where
  (<>) = (&&)

-- 整数の総和を求める関数
concat :: Semigroup a => a -> [a] -> a
concat = foldl (<>)

resultSum :: Integer
resultSum = concat 0 [1..100]

resultAll :: Bool
resultAll = concat True [True, True, True]
