{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE ScopedTypeVariables #-}
module M1.Class where

import qualified Control.Applicative as A
import qualified Control.Monad as M
import qualified Prelude as P
import Data.Function (flip)

class ToString a where
  toString :: a -> P.String

instance ToString P.Int where
  toString = P.show
  -- toString (3::Int), not toString 3::Int \iff toString 3 :: Int

instance ToString P.Bool where
  toString P.True = "True"
  toString P.False = "False"

data ExactlyOne a = ExactlyOne a deriving (P.Eq, P.Show)

runExactlyOne :: ExactlyOne a -> a
runExactlyOne (ExactlyOne x) = x

mapExactlyOne :: (a->b) -> ExactlyOne a -> ExactlyOne b
mapExactlyOne f (ExactlyOne x) = ExactlyOne (f x)

bindExactlyOne :: (a -> ExactlyOne b) -> ExactlyOne a -> ExactlyOne b
bindExactlyOne f (ExactlyOne x) = f x -- 함수 자체에서 constructor 로 return해주니까

instance P.Functor ExactlyOne where
  fmap = M.liftM  -- \iff <<=

instance A.Applicative ExactlyOne where
  (<*>) = M.ap
  pure = ExactlyOne

{- 
  flip :: (a->b->c)->b->a->c
  -- bindExactlyOne \iff a -> b -> c
  -- (->) curry : -> \iff a->(b->c) \equ a->b->c
--}
instance P.Monad ExactlyOne where
  (>>=) = flip bindExactlyOne 
  return = ExactlyOne
