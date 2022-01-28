module M1.Validation where

import Prelude(String,Bool(True,False),Eq,Show) 

data Validation a = Error Err | Value a deriving (Eq, Show)
type Err = String

isError :: Validation a -> Bool
isError (Error _) = True
isError (Value _) = False

isValue :: Validation a -> Bool
isValue (Error _) = False
isValue (Value _) = True

mapValidation :: (a -> b) -> Validation a -> Validation b
mapValidation _ (Error s) = Error s
mapValidation f (Value a) = Value (f a)
