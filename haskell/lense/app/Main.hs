module Main where
import GHC.ExecutionStack (Location(functionName))
main :: IO ()
main = do
  print "=============="
  print $ set (lense (\(i,j) -> j) (\(i,_) a -> (i,a))) 3 (1,2)
  print "=============="
  print $ set (lense bar (\s a -> s{bar=a})) (2,2) (CFoo (1,1) 'a')
  print "=============="
  print $ set (lense bar (\s a -> s{bar=a}) . (lense (\(i,j) -> j) (\(i,_) a -> (i,a)))) 3 (CFoo (1,1) 'a')

data Foo = CFoo {bar::(Int,Int),baz::Char}
instance Show Foo where
  show f = "Foo " <> show (bar f) <> show (baz f)

type Lense s a = (a->a) -> s -> s
lense :: (s->a) -> (s -> a -> s) -> Lense s a
lense sa sas afa s = sas s (afa (sa s))
set :: Lense s a -> a -> s -> s
set l a s = l (const a) s -- lense sa sas 가 실행될수 있도록 af s 를 lense 함수의 인자로 넘겨 줘야 한다.
{- set 인자로 넘겨주는 a 가 
  af (sa s) 에서 (sa s) 함수 결과로 만들어진 기존 view 값이  아닌 
  인자로 넘겨주는 a 로 갱신 해야 함으로 
  sa s 값을 무시하고 
  set 인자 a가 넘겨지도록 
  (a->a) 함수를 만들어 줘야 한다.
-}
 {- composite Lense
  1. l (cost a) s =>  set (lense_2 . lense_1) a s
      => set (lense_2 (lense_1 a s))
      => set (lense_2 (lense_1 (const a) s)
      => set (lense_2 (sas s (const a (sa s)))
      => set (lense_2 (sas s (a)))
      => set (lense_2 (\s a -> s) s )) == set (lense_2 (a->) s)
 -}
