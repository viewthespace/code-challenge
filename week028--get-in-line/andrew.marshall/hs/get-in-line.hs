#!/usr/bin/env stack
-- stack --resolver lts-13.8 script --ghc-options -Wall --ghc-options -threaded --ghc-options -rtsopts --ghc-options -with-rtsopts=-N --package containers

import Data.Function
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe
import Data.Set (Set)
import qualified Data.Set as Set

data Point = Point {x::Float, y::Float} deriving (Eq, Ord)
data Line =
  Function {aSlope :: Float, aYIntercept :: Float}
  | Vertical {aXIntercept :: Float}
  deriving (Eq, Ord)

parse :: String -> [Point]
parse str = map mkPoint (read str :: [[Float]])
  where mkPoint [x, y] = Point x y

slope :: Point -> Point -> Float
slope (Point x1 y1) (Point x2 y2) = (y1 - y2) / (x1 - x2)

yIntercept :: Point -> Point -> Float
yIntercept a@(Point x1 y1) b = y1 - ((slope a b) * x1)

lineBetween :: Point -> Point -> Line
lineBetween a@(Point x _) b =
  if isInfinite $ slope a b
  then Vertical x
  else Function (slope a b) (yIntercept a b)

combinations :: [a] -> [(a, a)]
combinations [] = []
combinations (x:xs) = map ((,) x) xs ++ combinations xs

linesOf :: [Point] -> Map Line (Set Point)
linesOf points =
  points
    & combinations
    & map (\(ptA, ptB) -> (lineBetween ptA ptB, Set.fromList [ptA, ptB]))
    & Map.fromListWith Set.union

maxLinePoints :: [Point] -> Int
maxLinePoints [_] = 1
maxLinePoints points =
  points
    & linesOf
    & Map.map Set.size
    & foldl max 0

main :: IO ()
main = do
  input <- getContents
  let result = maxLinePoints $ parse input
  putStrLn $ show result
