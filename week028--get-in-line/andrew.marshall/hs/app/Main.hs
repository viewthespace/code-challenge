module Main where

import Lib

main :: IO ()
main = do
  input <- getContents
  let result = maxLinePoints $ parse input
  putStrLn $ show result
