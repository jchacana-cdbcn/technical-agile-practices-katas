module GildedRose where

type GildedRose = [Item]

data Item = Item String Int Int
  deriving (Eq)

instance Show Item where
  show (Item name sellIn quality) =
    name ++ ", " ++ show sellIn ++ ", " ++ show quality

updateItemQuality :: Item -> Int

updateItemQuality (Item "Aged Brie" sellIn quality)
  | sellIn <= 0 = min (quality + 2) 50
  | otherwise   = min (quality + 1) 50

updateItemQuality (Item "Sulfuras, Hand of Ragnaros" sellIn quality) = quality

updateItemQuality (Item "Backstage passes to a TAFKAL80ETC concert" sellIn quality)
  = min (updateBackStagePassQuality sellIn quality) 50
 where
  updateBackStagePassQuality sellIn quality | sellIn <= 0  = 0
                                            | sellIn <= 5  = quality + 3
                                            | sellIn <= 10 = quality + 2
                                            | otherwise    = quality + 1

updateItemQuality (Item name sellIn quality)
  | sellIn <= 0 = max (quality - 2) 0
  | otherwise   = max (quality - 1) 0

updateItemSellIn :: Item -> Int
updateItemSellIn (Item name sellIn _)
  | name == "Sulfuras, Hand of Ragnaros" = sellIn
  | otherwise                            = sellIn - 1

updateQuality :: GildedRose -> GildedRose
updateQuality = map updateItem

updateItem item@(Item name sellIn quality) =
  let quality' = updateItemQuality item
      sellIn'  = updateItemSellIn item
  in  Item name sellIn' quality'
