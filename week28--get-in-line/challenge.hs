import Data.List

data Slope = Vertical | Horizontal | Sloped Float deriving(Show, Eq)

data Point = Point Float Float deriving(Eq)

instance Show Point where
         show (Point x y) = "Point(" ++ show (round x) ++ ", " ++ show (round y) ++ ")"

data SlopeReduction = SlopeReduction { point :: Point
                                     , slope :: Slope
                                     , pointCount :: Int
                                     } deriving(Show, Eq)

slopeBetween :: Point -> Point -> Slope
slopeBetween (Point x1 y1) (Point x2 y2) =
      if x2 == x1
         then Vertical
         else if y2 == y1
              then Horizontal
              else Sloped $ (y2 - y1) / (x2 - x1)

makePoint xy = Point (fromIntegral(xy !! 0)) (fromIntegral(xy !! 1))
toPoints pts = map makePoint pts

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs)-1] 
                                  , x <- combinations (n-1) (drop (i+1) xs) ]

hasSlope :: Slope -> SlopeReduction -> Bool
hasSlope s r = case r of
               SlopeReduction { point = _, slope = slope } -> slope == s

-- reducer :: ([SlopeReduction] -> Point -> Point) -> [SlopeReduction]
reducer a pts =
        let pt1 = pts !! 0
            pt2 = pts !! 1
            slope = slopeBetween pt1 pt2
        in case find (hasSlope slope) a of
             Just SlopeReduction { point = pt, slope = slope, pointCount = count } -> a ++ [SlopeReduction { point = pt, slope = slope, pointCount = count + 1 }]
             Nothing ->  a ++ [SlopeReduction { point = pt1, slope = slopeBetween pt1 pt2, pointCount = 2 }]

pointCombinations pts = combinations 2 $ toPoints pts 

output r = putStrLn $ show $ r

compareCount r1 r2 = case (r1, r2) of
             (SlopeReduction { point = _, slope = _, pointCount = count1 }, SlopeReduction { point = _, slope = _, pointCount = count2 }) -> compare count1 count2

-- pts = [[1, 1], [2, 2], [3, 3], [4, 5], [1,2]]
-- pts = [[1,1], [3,3], [4,1], [2,3]]
pts = [[1,1], [3,2], [5,3], [4,1], [2,3], [1,4]]
segments = pointCombinations pts
reductions = foldl reducer [] segments
main = output $ maximumBy compareCount reductions


-- pt1 = Point 1 1
-- pt2 = Point 2 2
-- reduction = SlopeReduction { point = pt1, slope = Sloped 1.0, pointCount = 2 }
-- main = output $ (reducer [reduction] pt1 pt2)
