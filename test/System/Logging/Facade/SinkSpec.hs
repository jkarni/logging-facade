module System.Logging.Facade.SinkSpec (main, spec) where

import           Helper

import           System.Logging.Facade
import           System.Logging.Facade.Types
import           System.Logging.Facade.Sink

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "withLogSink" $ do
    it "sets the global log sink to specified value before running specified action" $ do
      (getLogRecords, sink) <- mkCaptureLogSink
      withLogSink sink $ do
        info "some log message"
        getLogRecords `shouldReturn` [LogRecord INFO Nothing "some log message"]

    it "restores the original log sink when done" $ do
      (getLogRecords, sink) <- mkCaptureLogSink
      setLogSink sink
      withLogSink (\_ -> return ()) (return ())
      info "some log message"
      getLogRecords `shouldReturn` [LogRecord INFO Nothing "some log message"]
