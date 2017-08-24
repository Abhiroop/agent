{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE ExistentialQuantification #-}


module Paxos where

import Data.Binary
import Data.Typeable

import GHC.Generics

newtype RoundNo = RoundNo Int deriving (Typeable, Generic)

instance Binary RoundNo

data Value a = Value a deriving (Typeable, Generic)

instance Binary a => Binary (Value a)

data Message a = Plebiscit                     -- Round Leader sends
               | Allegiance (Value a, RoundNo) -- Witness responds
               | Propose (Value a, RoundNo)    -- Leader sends the selected value
               | Accept (Value a, RoundNo)     -- Witness sends to leader
               | Decision (Value a, RoundNo)   -- Leader sends to witnesses
               deriving (Typeable, Generic)

instance Binary a => Binary (Message a)


