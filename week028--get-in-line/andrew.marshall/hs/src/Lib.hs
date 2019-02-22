module Lib (
  parse,
  maxLinePoints
) where

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

mkPoint [x, y] = Point x y

parse :: String -> [Point]
parse str = map mkPoint $ (read str :: [[Float]])

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

mkMap :: Ord k => (v -> v -> v) -> [(k, v)] -> Map k v
mkMap combiner = foldl update Map.empty
  where
    update m (k, v) = Map.alter (alter v) k m
    alter v = return . fromMaybe v . fmap (combiner v)

linesOf :: [Point] -> Map.Map Line (Set Point)
linesOf points =
  points
    & combinations
    & map (\(ptA, ptB) -> (lineBetween ptA ptB, Set.fromList [ptA, ptB]))
    & mkMap Set.union

maxLinePoints :: [Point] -> Int
maxLinePoints [] = 0
maxLinePoints [_] = 1
maxLinePoints points =
  points
    & linesOf
    & Map.map Set.size
    & maximum
