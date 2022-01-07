module Ch01.Chapter01 where
data Void
-- data () = ()
data Bool = False | True
-- cardinality 2
-- to :: s -> t
-- from :: t -> s
-- from . to = id
-- to . from = id
data Spin = Up | Down
--cardinality 2

boolToSpin1 :: Bool -> Spin
boolToSpin1 False = Up
boolToSpin1 True = Down

spinToBool1 :: Spin -> Bool
spinToBool1 Up -> False
spinToBool1 Down -> Up

boolToSpin2 :: Spin -> Bool 
boolToSpin2 False = Down
boolToSpin2 True = Up

spinToBool2 :: Bool -> Spin
spinToBool2 Up -> True
spinToBool2 Down -> False
