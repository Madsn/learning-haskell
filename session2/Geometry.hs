module Geometry
( Point
, smart_mk_point
, move_left
) where

data Point = MkPoint (Int,Int) deriving (Eq,Show)

smart_mk_point :: (Int,Int) -> Maybe Point
smart_mk_point (x,y) =
  if
    abs x < 5 && abs y < 5
  then
    Nothing
  else
    Just . MkPoint $ (x,y)

move_left point =
  smart_mk_point ( x - 1, y )
    where
      (MkPoint (x,y)) = point

-- λ> smart_mk_point (6,0)
-- Just (MkPoint (6,0))
-- λ> 
-- λ> smart_mk_point (6,0) >>= move_left
-- Just (MkPoint (5,0))
-- λ> 
-- λ> smart_mk_point (6,0) >>= move_left >>= move_left
-- Nothing
