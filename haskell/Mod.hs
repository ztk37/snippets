module Main (main) where

import Data.Char (toUpper)
import Data.Semigroup (Semigroup, (<>))

data Mod a = Mod (a -> a)

applyMod :: Mod a -> a -> a
applyMod (Mod f) x = f x

instance Semigroup (Mod a) where
  (Mod f) <> (Mod g) = Mod (f . g)
  
instance Monoid (Mod a) where
  mempty = Mod id
  mappend = (<>)

type ModStr = Mod String
type ModInt = Mod Int

reverseMS :: ModStr
reverseMS = Mod reverse

toUpperMS :: ModStr
toUpperMS = Mod $ map toUpper

doubleMI :: ModInt
doubleMI = Mod (*2)

addNMI :: Int -> ModInt
addNMI n = Mod (+n)

incMI :: ModInt
incMI = addNMI 1

main :: IO ()
main = do
  print $ applyMod (reverseMS <> toUpperMS) "derp"
  print $ applyMod (doubleMI <> addNMI 4) 17
