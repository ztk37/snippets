import Control.Monad.Reader
import Control.Monad.Writer
import Control.Monad.State
-- import Control.Monad.Except

type SomeEnv = [(String, Bool)]
type SomeState = [(String, String)]
type SomeLog = [String]

-- Stack all the things!

type RWS a = ReaderT SomeEnv (WriterT SomeLog (StateT SomeState IO)) a

runRWS :: RWS a -> IO ((a, SomeLog), SomeState)
runRWS = flip runStateT [] . runWriterT . flip runReaderT []

type RSW a = ReaderT SomeEnv (StateT SomeState (WriterT SomeLog IO)) a

runRSW :: RSW a -> IO ((a, [(String, String)]), SomeLog)
runRSW = runWriterT . flip runStateT [] . flip runReaderT []

type WRS a = WriterT SomeLog (ReaderT SomeEnv (StateT SomeState IO)) a

runWRS :: WRS a -> IO ((a, SomeLog), SomeState)
runWRS = flip runStateT [] . flip runReaderT [] . runWriterT

type WSR a = WriterT SomeLog (StateT SomeState (ReaderT SomeEnv IO)) a

runWSR :: WSR a -> IO ((a, SomeLog), SomeState)
runWSR = flip runReaderT [] . flip runStateT [] . runWriterT

type SRW a = StateT SomeState (ReaderT SomeEnv (WriterT SomeLog IO)) a

runSRW :: SRW a -> IO ((a, SomeState), SomeLog)
runSRW = runWriterT . flip runReaderT [] . flip runStateT []

type SWR a = StateT SomeState (WriterT SomeLog (ReaderT SomeEnv IO)) a

runSWR :: SWR a -> IO ((a, SomeState), SomeLog)
runSWR = flip runReaderT [] . runWriterT . flip runStateT []
