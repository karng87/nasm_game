module M1.Optional where 

import Prelude(Eq,Show)

data Optional a = Full a | Empty deriving (Eq,Show)

mapOptional :: (a -> b) -> Optional a -> Optional b
mapOptional f (Full x) = Full (f x)
mapOptional _ _ = Empty

bindOptional :: (a -> Optional b) -> Optional a -> Optional b
bindOptional f (Full x) = f x
bindOptional _ _ = Empty

(??) :: Optional a -> a -> a
(??) (Full x) _ = x
(??) _        y = y

(<+>) :: Optional a -> Optional a -> Optional a
(<+>) (Full x) _        = Full x
(<+>) _       (Full x)  = Full x
(<+>) _       _ = Empty

applyOptional :: Optional (a->b) -> Optional a -> Optional b
-- applyOptional f o = bindOptional (\f' -> mapOptional f' o) f
applyOptional f o = bindOptional (`mapOptional` o) f
