{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where
import Data.Text(Text)
import System.Random(getStdRandom, randomR)
import Data.Foldable(fold)
import Data.Monoid(getSum)

main :: IO ()
main = putStrLn "Hello, Haskell!"

newtype Money = Money {unMoney::Double} deriving (Show,Eq,Num)
newtype ProjectId = ProjectId {unProjectId::Int} deriving(Show,Eq,Num)
data Project = Project ProjectId Text | ProjectGroup Text [Project] deriving (Show,Eq)
data Budget = Budget {budgetIncome::Money,budgetExpenditure::Money} deriving (Show,Eq)
data Transaction = Sale Money | Purchase Money deriving (Show, Eq)

someProject :: Project
someProject = ProjectGroup "Sweden" [stockholm, gothenburg, malmo]
  where
    stockholm = Project 1 "Stockholm"
    gothenburg = Project 2 "Gothenburg"
    malmo = ProjectGroup "malmo" [city, limhamn]
    city = Project 3 "malmo City"
    limhamn = Project 4 "Limhamn"

getBudget :: ProjectId -> IO Budget
getBudget _ = do
  income <- Money <$> getStdRandom (randomR (0, 10000))
  expenditure <- Money <$> getStdRandom (randomR (0, 10000))
  pure Budget { budgetIncome = income
              , budgetExpenditure = expenditure
              }

getTransactions :: ProjectId -> IO [Transaction]
getTransactions _ = do
  sale <- Sale . Money <$> getStdRandom (randomR (0, 4000))
  purchase <- Purchase . Money <$> getStdRandom (randomR (0, 4000))
  pure [sale, purchase]

data Report = Report{budgetProfit::Money,netProfit::Money,difference::Money}deriving(Show,Eq)
calculateReport :: Budget -> [Transaction] -> Report
calculateReport budget transaction = Report{
  budgetProfit = budgetProfit',
  netProfit = netProfit',
  difference = netProfit' - budgetProfit' }
  where
    budgetProfit' = budgetIncome budget - budgetExpenditure budget
    netProfit' = getSum(foldMap asProfit transaction)
    asProfit (Sale m) = pure m
    asProfit (Purchase m) = pure (negate m)
