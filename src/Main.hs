{-# LANGUAGE OverloadedStrings #-}
module Main where
import Prelude as P
--import Control.Monad (forM_)
import Control.Monad 
import Control.Monad.IO.Class 
import Database.HDBC
import Database.HDBC.ODBC
--import Database.HDBC.MySQL
import Data.ByteString.Lazy as BS 
import Data.HashMap.Strict as Hash
import Data.Monoid (mconcat)
import Data.Binary.Builder as Bldr
import Data.Text.Lazy.Encoding as TE
import Data.Text as T
import Data.Map.Syntax
import Heist
import Heist.Interpreted as I
import Network.HTTP.Types
import qualified Data.Text.Lazy as LT
import Control.Lens as L
import Network.Wai.Middleware.Static
import Text.Blaze.Html5 as H hiding (main)
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Utf8 as Hr
import Text.Blaze.Html.Renderer.Text as Ht
import Text.Blaze.Renderer.XmlHtml
import Text.XmlHtml
import Text.Printf
import Web.Scotty as Scty
import Web.Scotty.Internal.Types
------
import BlazeUtil
-- import RTSSignalBlocker
--------------------------------------------------------------------------------
templateLocation::Text
templateLocation = "c:/Users/brent/toolcrib/templates/"
--------------------------------------------------------------------------------
connectionString1::String
connectionString1 = "Driver={MariaDB ODBC 3.1 Driver};\
                            \Server=192.168.0.19;Database=diamondoj;\
                            \Uid=root;Pwd=!Diamond714;Port=3307"
connectionString2::String
connectionString2 = "DSN=DiamondMfgReadOnly;ServerName=192.168.0.27.1583;ArrayFetchOn=1;\
\ArrayBufferSize=8;TransportHint=TCP;DBQ=DIAMONDMFG\
\          ;OpenMode=1;ClientVersion=15.00.050.000;CodePageConvert=1252;\
\PvClientEncoding=CP1252;PvServerEncoding=CP1252;PvTranslate=auto;AutoDoubleQuote=0;"

connectionString3::String
connectionString3 = "DSN=diamondoj;Trace=Yes;TraceFile=trace.log;"

connectionString::String
connectionString = connectionString1 
--------------------------------------------------------------------------------
main :: IO ()
main = do

--withRTSSignalsBlocked :: IO a -> IO a
--  withRTSSignalsBlocked $ do
    --    print "whoop"
-- {-
    conn<-handleSqlError $ do
        conn <- connectODBC connectionString 
        return conn
    colDesc <-describeTable conn "tools"    
    let colNames = fmap fst colDesc
    print colNames
--    print =<< describeTable conn "tools"    
--    conn<-catchSql connectDB (\e->print e)
    ----
-- -}
--    table <- do
 --      stmt<-prepare conn "Select * from tools"
  --     table<- fetchAllRows stmt
   --    return table
   -- print table
{-
    tables<-getTables conn 
    print tables
    desc <- describeTable conn "bin"    
    print desc
-}
    let hc =  set hcInterpretedSplices defaultInterpretedSplices $
              hcInterpretedSplices .~ ("tableSplice" ## tableSplice [] [[]]) $ 
              hcInterpretedSplices .~ ("intSplice" ## intSplice 1) $ 
              hcTemplateLocations .~ [loadTemplates $ T.unpack templateLocation] $ 
              set hcNamespace "" emptyHeistConfig::HeistConfig ActionM

    eitherHc <- initHeist (hc::HeistConfig ActionM)
    let hSt = getState eitherHc
    ------
    scotty 3000 $ doit conn hSt 

--------------------------------------------------------------------------------
doit:: Connection-> HeistState ActionM -> ScottyT LT.Text IO ()
doit conn hSt = do 
--      conn<- do 
 --            liftM connectODBC connectionString 
--      conn2<- return $ connectODBC connectionString 
      middleware $ staticPolicy (addBase "static")
    ----
      get "/test/:word" $ do
        beam <- Scty.param "word"
        Scty.html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]    
    ----
      addroute GET "/" $ Scty.text "dammit, jim, I'm a doctor, not a haskell programmer"
    ----
      addroute GET "/test2" $ do
          result<- liftAndCatchIO $ quickQuery conn "Select * from tools" []
          let result' = fmap (++ [SqlString"\n"]) result ::[[SqlValue]]
          let a = P.concat result' :: [SqlValue]
          let b = fmap ((T.append "\t").fromSql) a :: [Text]
          let d = T.concat b :: Text
          Scty.html  $ LT.fromStrict d
    ----
      addroute GET "/splice" $ do 
        let ct = callTemplate "test" ("intSplice" ## intSplice 2)
        tst<-evalHeistT ct (TextNode "") hSt 
        let bdr = renderHtmlFragment UTF8 tst
        Scty.html $ TE.decodeUtf8 $ toLazyByteString bdr
    ----
      addroute GET "/splice_tab" $ do 
        colDesc <-liftAndCatchIO $ describeTable conn "tools"    
--        colDesc <-liftAndCatchIO $ describeTable conn "ROUTING"    
        let colNames = fmap (T.pack.fst) colDesc

--        table<- liftAndCatchIO $ quickQuery conn "Select * from tools order by majorDia" []
{-
        table <-liftAndCatchIO $ do
           stmt<-prepare conn "Select * from tools"
           table<- fetchAllRows stmt
           return table
        let rows = convert2Text table
        let ct = callTemplate "tools" ("tableSplice" ## tableSplice colNames rows)
        tst<-evalHeistT ct (TextNode "") hSt 
        let bdr = renderHtmlFragment UTF8 tst
-}
--        Scty.html $ TE.decodeUtf8 $ toLazyByteString bdr

--        Scty.html $ mconcat ["<h1>Scotty, beam me up!</h1>"]    
        Scty.html $  LT.fromChunks colNames    
    ----
      addroute POST "/splice_tab" $ do 
            return ()
{-        response<-Scty.body
        colDesc <-liftAndCatchIO $ describeTable conn "tools"    
        let colNames = fmap (T.pack.fst) colDesc
        let response' = (sanitizeString.show) response

--        table<- liftAndCatchIO $ 
 --           quickQuery conn ("Select * from tools order by " ++ (response'))[]

        stmt<-liftAndCatchIO $ prepare conn "Select * from tools"
        table<- liftAndCatchIO $ fetchAllRows stmt

        let rows = convert2Text table
        let newHtml = toHtml $ blazeTable colNames rows
        Scty.html $ Ht.renderHtml newHtml 
-}
    ----
      addroute GET "/test3" $ do -- 
        maybBuilder<- renderTemplate hSt "receipt"
        bdr<- case maybBuilder of
            Just (buildr,mime)-> do
                return buildr
            Nothing -> return Bldr.empty
        Scty.html $ TE.decodeUtf8 $ toLazyByteString bdr

      return ()
--------------------------------------------------------------------------------
--take off any extra quotes, then add back quotes in case of double words for 
--sql values
sanitizeString::String->String
sanitizeString str = 
    let noQuote= P.filter (\x->x /= '"') str
    in "`" ++ noQuote ++ "`"
--------------------------------------------------------------------------------
convertSql2Text::[SqlValue]->[T.Text]
convertSql2Text [] = []
convertSql2Text (x:xs) = format x : convertSql2Text xs
--------------------------------------------------------------------------------
format::SqlValue->Text
format (SqlDouble n) = T.pack $ printf "%.3f" n
format x = fromSql x
--------------------------------------------------------------------------------
convert2Text::[[SqlValue]]->[[T.Text]]
convert2Text  [] = []
convert2Text (x:xs) = convertSql2Text x : convert2Text xs 
--------------------------------------------------------------------------------
nullSplice:: I.Splice ActionM
nullSplice = return $ renderHtmlNodes "<h1>NULL</h1>"
--------------------------------------------------------------------------------
intSplice:: Int -> I.Splice ActionM
intSplice i = return $ renderHtmlNodes $ toHtml $ h1 $ 
                string ("Int is : " ++ show i ++ " m'kay")
------------------------------------------------------------------------------
tableSplice::[T.Text]->[[T.Text]]->I.Splice ActionM
tableSplice headings rows= do
    return $ renderHtmlNodes $ blazeTable headings rows
--------------------------------------------------------------------------------
bootStrapWarning::T.Text->I.Splice ActionM
bootStrapWarning msg = do
    return $ renderHtmlNodes $ bootStrapWarn msg
------------------------------------------------------------------------------
-- |
autoCompleteSplice::T.Text -> [T.Text]->I.Splice ActionM
autoCompleteSplice listId txt =
    return $ renderHtmlNodes $ blazeDataList listId txt
--------------------------------------------------------------------------------
getState::(Either [String] (HeistState ActionM))->HeistState ActionM
getState hs= do
     case hs of
        Right r->r
        Left s -> error $ show s
--------------------------------------------------------------------------------
connectDB::IO Connection
connectDB = do
    conn <- connectODBC connectionString 
    return conn
-------------------------------------------------------------------------------- 










