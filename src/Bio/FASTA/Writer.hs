module Bio.FASTA.Writer
  ( fastaToText
  ) where

import           Bio.FASTA.Type (Fasta, FastaItem(..))
import           Bio.Sequence   (BareSequence, sequ)
import           Control.Lens    ((^.))
import           Data.Text      (Text, append, pack)
import           Data.Vector (Vector, toList, slice, drop)
import           Prelude hiding (drop)

fastaToText :: Fasta Char -> Text
fastaToText [] = ""
fastaToText (x : xs) = writeItem x `append` fastaToText xs

writeItem :: FastaItem Char -> Text
writeItem (FastaItem name s) = ">" `append` name `append` "\n" `append` seq2Text s

seq2Text :: BareSequence Char -> Text
seq2Text s = pack $ vector2Text $ s ^. Bio.Sequence.sequ

vector2Text :: Vector Char -> String
vector2Text v | length v > 80 = vector2Text (slice 0 80 v) ++ vector2Text (drop 80 v)
              | otherwise = toList v ++ "\n"