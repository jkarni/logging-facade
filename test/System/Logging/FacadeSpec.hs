module System.Logging.FacadeSpec (main, spec) where

import           Helper

import           System.Logging.Facade.Types
import           System.Logging.Facade.Sink
import           System.Logging.Facade

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "info" $ do
    it "writes a log message with log level INFO" $ do
      (getLogRecords, sink) <- mkCaptureLogSink
      withLogSink sink $ do
        info "some log message"
        getLogRecords `shouldReturn` [LogRecord INFO Nothing "some log message"]
