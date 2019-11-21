module Bio.MAE.Type
  ( Mae (..)
  , Block (..)
  , Table (..)
  , Value (..)
  , FromValue (..)
  ) where

import           Data.Map.Strict (Map)
import           Data.Maybe      (fromJust)
import           Data.Text       (Text)

data Mae = Mae { version :: Text
               , blocks  :: [Block]
               }
  deriving (Eq, Show)

data Block = Block { blockName :: Text
                   , fields    :: Map Text Value
                   , tables    :: [Table]
                   }
  deriving (Eq, Show)

data Table = Table { tableName :: Text
                   , contents  :: Map Text [Value]
                   }
  deriving (Eq, Show)                   

data Value = IntValue Int
           | RealValue Float
           | StringValue Text
           | BoolValue Bool
           | Absent
  deriving (Eq, Show)

class FromValue a where
    fromValue :: Value -> Maybe a

    unsafeFromValue :: Value -> a
    unsafeFromValue = fromJust . fromValue

instance FromValue Int where
    fromValue :: Value -> Maybe Int
    fromValue (IntValue i) = Just i
    fromValue _            = Nothing

instance FromValue Float where
    fromValue :: Value -> Maybe Float
    fromValue (RealValue f) = Just f
    fromValue _             = Nothing

instance FromValue Bool where
    fromValue :: Value -> Maybe Bool
    fromValue (BoolValue b) = Just b
    fromValue _             = Nothing

instance FromValue Text where
    fromValue :: Value -> Maybe Text
    fromValue (StringValue t) = Just t
    fromValue _               = Nothing