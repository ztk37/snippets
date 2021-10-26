
module Main (main) where

import           Data.Monoid (Endo(..))

import           Control.Monad.Writer

data ItemMeta = ItemMeta
  { itemMetaQuantity :: Int
  } deriving (Eq, Show)

type ItemMetaM = Writer (Endo ItemMeta) ()

defaultItemMeta :: ItemMeta
defaultItemMeta = ItemMeta
  { itemMetaQuantity = 1
  }

execItemMetaM :: ItemMetaM -> ItemMeta
execItemMetaM = flip appEndo defaultItemMeta . execWriter

data ItemInfo = ItemInfo
  { itemName :: String
  , itemMeta :: ItemMeta
  } deriving (Eq, Show)

item :: String -> ItemMetaM -> Writer [ItemInfo] ()
item s metaM = tell $ [ItemInfo s (execItemMetaM metaM)]

item' :: String -> Writer [ItemInfo] ()
item' s = tell $ [ItemInfo s defaultItemMeta]

quantity :: Int -> ItemMetaM
quantity n = tell $ Endo $ \meta -> meta { itemMetaQuantity = n }

items :: ItemsM
items = do
  item "A" $ do
    quantity 2
  
  item "B" $ do
    quantity 3

  item "C" $ do
    quantity 1

  item' "D"

type ItemsM = Writer [ItemInfo] ()

execItemsM :: ItemsM -> [ItemInfo]
execItemsM = execWriter

-- TODO: pretty print
pprintItems :: [ItemInfo] -> IO ()
pprintItems = mapM_ print

main :: IO ()
main = pprintItems $ execItemsM items
