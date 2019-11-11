module GildedRose where

type GildedRose = [Item]

data Item = Item String Int Int
  deriving (Eq)

instance Show Item where
  show (Item name sellIn quality) =
    name ++ ", " ++ show sellIn ++ ", " ++ show quality


updateItemQuality :: Item -> Int
updateItemQuality (Item "Aged Brie" sellIn quality) =
  if quality >= 50 then quality else quality + 1
updateItemQuality (Item "Sulfuras, Hand of Ragnaros" sellIn quality) = quality
updateItemQuality (Item "Backstage passes to a TAFKAL80ETC concert" sellIn quality)
  = if quality >= 50
    then quality
    else increaseBackStagePassQuality sellIn quality
updateItemQuality (Item name sellIn quality) =
  if quality > 0 then quality - 1 else quality

increaseBackStagePassQuality sellIn quality =
  quality + qualityIncrease
  where qualityIncrease
          | sellIn < 6 && quality <= 47 = 3
          | sellIn < 11 && quality <= 48 = 2
          | otherwise = 1

updateQuality :: GildedRose -> GildedRose
updateQuality = map updateQualityItem
 where
  updateQualityItem (Item name sellIn quality) =
    let quality' = updateItemQuality (Item name sellIn quality)

        sellIn' =
            if name /= "Sulfuras, Hand of Ragnaros" then sellIn - 1 else sellIn
    in  if sellIn' < 0
          then if name /= "Aged Brie"
            then if name /= "Backstage passes to a TAFKAL80ETC concert"
              then if quality' > 0 && name /= "Sulfuras, Hand of Ragnaros"
                then (Item name sellIn' (quality' - 1))
                else (Item name sellIn' quality')
              else (Item name sellIn' 0)
            else if quality' < 50
              then (Item name sellIn' (quality' + 1))
              else (Item name sellIn' quality')
          else (Item name sellIn' quality')
