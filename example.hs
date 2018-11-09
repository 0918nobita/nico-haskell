{-# LANGUAGE GeneralizedNewtypeDeriving #-}

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

-- 半群の言い回しとして、Integer と + のインスタンスをとって『半群 (Integer, +)』と言ったりする
-- 半群のベースとなる集合 Integer を、『半群 (Integer, +) の台集合』という

-- 台集合に対して半群は必ずしも 1 つではない
-- 集合 Integer は半群 (Integer, *) にもなる
-- 集合 Bool は半群 (Bool, ||) にもなる
-- newtype を使ってそれを表現してみる

newtype Sum = Sum { unSum :: Integer } deriving (Show, Eq, Num, Enum)

newtype Product = Product { unProduct :: Integer } deriving (Show, Eq, Num, Enum)

newtype RSum = RSum { unRSum :: Rational } deriving (Show, Eq, Num, Enum)

newtype RProduct = RProduct { unRProduct :: Rational } deriving (Show, Eq, Num, Enum)

newtype And = And { unAnd :: Bool } deriving (Show, Eq)

newtype Or = Or { unOr :: Bool } deriving (Show, Eq)

xor :: Bool -> Bool -> Bool
xor True True = False
xor True False = True
xor False True = True
xor False False = False

newtype Xor = Xor { unXor :: Bool } deriving (Show, Eq)

instance Semigroup Sum where
  (<>) = (+)

instance Semigroup Product where
  (<>) = (*)

instance Semigroup And where
  And x <> And y = And $ x && y

instance Semigroup Or where
  Or x <> Or y = Or $ x || y

instance Semigroup Xor where
  Xor x <> Xor y = Xor $ x `xor` y

aSumInt :: Sum
aSumInt = Sum 10 <> Sum 20

aProductInt :: Product
aProductInt = Product 10 <> Product 20

instance Semigroup RSum where
  (<>) = (+)

instance Semigroup RProduct where
  (<>) = (*)

instance Semigroup [a] where
  (<>) = (++)

instance Semigroup () where
  () <> () = ()

class Semigroup a => Abelian a
