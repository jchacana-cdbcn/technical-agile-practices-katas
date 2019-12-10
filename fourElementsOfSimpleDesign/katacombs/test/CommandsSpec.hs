module CommandsSpec (spec) where

import Test.Hspec
import Commands
import Model
import Data.Function ((&))
import qualified Data.Map as Map
import qualified GameState as GS

spec :: Spec
spec = do
    let center = Location "center" ""
        east = Location "east" "the location to the east"
        west = Location "west" ""
        north = Location "north" "the location to the north"
        south = Location "south" ""
        gameMap = Map.fromList
            [ ((0, 0), center)
            , ((1, 0), east)
            , ((-1, 0), west)
            , ((0, 1), north)
            , ((0, -1), south)
            ]
        items = GS.createItems
            [ (Item (ItemName "a golden statue") "", (0, 1))
            , (Item (ItemName "a silver key") "", (0, 1))
            , (Item (ItemName "rusty key") "The head of this rusty key resembles a heart.", (0, 0))
            , (Item (ItemName "flute") "The flute is a musical instrument.", (0, 0))]
        state = GameState { playerAt = (0, 0), items = items }
        stateAfterCommand command = snd $ doCommand gameMap command state
        messageAfterCommand command = fst $ doCommand gameMap command state
    
    describe "go" $ do
        it "should move to the north" $ do
            let nextState = stateAfterCommand (Go North) 
            getPlayerLocation gameMap nextState `shouldBe` north
        it "should move to the south" $ do
            let nextState = stateAfterCommand (Go South) 
            getPlayerLocation gameMap nextState `shouldBe` south
        it "should move to the east" $ do
            let nextState = stateAfterCommand (Go East) 
            getPlayerLocation gameMap nextState `shouldBe` east
        it "should move to the west" $ do
            let nextState = stateAfterCommand (Go West) 
            getPlayerLocation gameMap nextState `shouldBe` west
        
        it "should also return title and description of the new location" $ do
            let message = messageAfterCommand (Go East) 
            message `shouldBe` "east\nthe location to the east"
        it "should also show a description of the items in the location" $ do
            let message = messageAfterCommand (Go North) 
            message `shouldBe` "north\nthe location to the north\nItems in the location: 'a golden statue' 'a silver key'"

    describe "look" $ do
        it "should display a message after looking north" $ do
            let message = messageAfterCommand (Look North)
            message `shouldBe` "You see the North"
        it "should display a message after looking south" $ do
            let message = messageAfterCommand (Look South)
            message `shouldBe` "You see the South"
    describe "lookAt" $ do
        it "should display a description after looking at an item" $ do
            let message = messageAfterCommand (LookAt $ ItemName "rusty key")
            message `shouldBe` "The head of this rusty key resembles a heart."
        it "should display a description when there is no such item to look at" $ do
            let message = messageAfterCommand (LookAt $ ItemName "item that is not there")
            message `shouldBe` "There is no 'item that is not there' here."
    describe "take" $ do
        it "should display a message when picking up an item" $ do
            let message = messageAfterCommand (Take $ ItemName "rusty key")
            message `shouldBe` "You picked up rusty key"
        it "should display a message when there is no such item in the location" $ do
            let message = messageAfterCommand (Take $ ItemName "item that is not there")
            message `shouldBe` "There is no 'item that is not there' here."
        it "should add the item to the player inventory" $ do
            let nextState = stateAfterCommand (Take $ ItemName "rusty key")
                itemsInBag = map itemName $ GS.bag nextState
            itemsInBag `shouldBe` [ItemName "rusty key"]
    describe "bag" $ do
        it "should display the names of the items in the bag sorted alphabetically" $ do
            let message = state
                    & doCommand gameMap (Take $ ItemName "rusty key")
                    & snd
                    & doCommand gameMap (Take $ ItemName "flute")
                    & snd
                    & doCommand gameMap Bag
                    & fst
            message `shouldBe` "The bag contains: 'flute' 'rusty key'"
        it "should display a message when the bag is empty" $ do
            let message = messageAfterCommand (Bag)
            message `shouldBe` "The bag is empty."