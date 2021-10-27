module Main (main) where

import Data.Functor.Identity (Identity(..))
import Data.Monoid (Endo(..))

import Control.Monad.Writer

type EndoT m a = WriterT (Endo a) m ()

type EndoM a = EndoT Identity a

modify :: Monad m => (a -> a) -> EndoT m a
modify f = tell $ Endo f

main :: IO ()
main = return ()
