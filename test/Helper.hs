module Helper (
  module Test.Hspec
, mkCaptureLogSink
) where

import           Test.Hspec
import           Data.IORef

import           System.Logging.Facade.Types
import           System.Logging.Facade.Sink

mkCaptureLogSink :: IO (IO [LogRecord], LogSink)
mkCaptureLogSink = do
  ref <- newIORef []
  let sink :: LogSink
      sink record = modifyIORef ref (record :)
  return (readIORef ref, sink)
