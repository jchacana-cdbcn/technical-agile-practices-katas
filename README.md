# Agile Technical Practice Katas

This repo contains katas from the book **Agile Technical Practices Distilled: A Journey Toward Mastering Software Design**.

![](https://d2sofvawe08yqg.cloudfront.net/agiletechnicalpracticesdistilled/hero2x?1549503021 "Agile Technical Practices Distilled: A Journey Toward Mastering Software Design")

## Contents
- Classic TDD I
    - Fizz Buzz
    - Leap Year
    - [Nth Fibonacci](tdd/fibonacci.hs)
- Classic TDD II
    - Stats Calculator
    - Anagrams
- Classic TDD III
    - [Roman Numerals (without TPP)](tdd/romanNumerals.hs)
    - [Prime factors](tdd/primefactors.hs)
- Design I - Object Calisthenics
    - [Tic Tac Toe](calisthenics/tictactoe.hs)
- Testing Legacy Code
    - [Characterization tests on Gilded Rose kata](testingLegacyCode/gildedRose/test/GildedRoseSpec.hs)
    - [Golden Master on Gilded Rose kata](testingLegacyCode/gildedRose/goldenMasterTest.sh)
    - [Gilded Rose kata](testingLegacyCode/gildedRose/)
- Design VIII - The four elements of simple design
    - [Katacombs of Shoreditch](fourElementsOfSimpleDesign/katacombs)
- Outside-In Development
    - [Stock portfolio](outsideInDevelopment/stockportfolio.hs)

## Running the code
You need to have [GHC](https://www.haskell.org/downloads/) and [Hspec](https://hspec.github.io/) installed.
```
$ ghci

Prelude> :load tdd/fibonacci.hs 
[1 of 1] Compiling Main             ( tdd/fibonacci.hs, interpreted )
Ok, modules loaded: Main.

*Main> main
fib returning elements of the fibonacci sequence
  returns the 0th element
  returns the 1st element
  returns the 2nd element
  returns the 3rd element
  returns the 9th element

Finished in 0.0032 seconds
5 examples, 0 failures
```