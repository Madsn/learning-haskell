-- Don't define your types like this:
-- data Inches = Inches Double
-- data Cm     = Cm     Double

-- Define them like this:
-- data Inches = MkInches Double
-- data Cm     = MkCm     Double

-- Automatically derive their string representation and equality checks:
data Inches = MkInches Double deriving (Eq,Show)
data Cm     = MkCm     Double deriving (Eq,Show)

-- Inches can only be added to Inches, Cm only to Cm
class UnitRestrictable a where
  (\+/) :: a -> a -> a
  (\-/) :: a -> a -> a

instance UnitRestrictable Inches where
  (MkInches u) \+/ (MkInches v) = MkInches ( u + v )
  (MkInches u) \-/ (MkInches v) = MkInches ( u - v )

instance UnitRestrictable Cm where
  (MkCm u) \+/ (MkCm v) = MkCm ( u + v )
  (MkCm u) \-/ (MkCm v) = MkCm ( u - v )

vin1 :: Inches
vin1 = MkInches 2.0

vin2 :: Inches
vin2 = MkInches 5.0

vcm1 :: Cm
vcm1 = MkCm 2.0

vcm2 :: Cm
vcm2 = MkCm 7.0

-- From http://en.wikipedia.org/wiki/Mars_Climate_Orbiter#Cause_of_failure
-- The primary cause of this discrepancy was that one piece
-- of ground software produced results in an "English system" unit,
-- while a second system that used those results expected them
-- to be in metric units. Software that calculated the total impulse
-- produced by thruster firings calculated results in pound-seconds.
-- The trajectory calculation used these results to correct
-- the predicted position of the spacecraft for the effects of thruster firings.
-- This software expected its inputs to be in newton-seconds.

from_inches_to_cm :: Inches -> Cm
from_inches_to_cm vin =
  MkCm (vin_as_pure_double * 2.54)
    where
      (MkInches vin_as_pure_double) = vin

from_cm_to_inches :: Cm -> Inches
from_cm_to_inches vcm =
  MkInches (vcm_as_pure_double * 0.393701)
    where
      (MkCm vcm_as_pure_double) = vcm
