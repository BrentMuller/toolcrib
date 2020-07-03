{-# LANGUAGE OverloadedStrings #-}
module Main where
import Control.Monad (forM_)
import Text.Blaze.Html5 as H hiding (main)
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Utf8 as Hr
import Text.Blaze.Renderer.XmlHtml
import Text.XmlHtml
--import Text.Blaze.Html.Renderer.String as Hr
import Data.ByteString.Char8 as BS 
import Database.HDBC
import Database.HDBC.ODBC
import Web.Scotty as Scty
import Web.Scotty.Internal.Types
import Data.Monoid (mconcat)
import Data.Binary.Builder as Bldr
--import Data.Text
import Data.Text.Lazy.Encoding as TE
import Heist
import Heist.Interpreted as I
import Network.HTTP.Types
import Data.Text.Lazy as T
import Data.Map.Syntax
import Data.HashMap.Strict as Hash
import Lens.Simple as L
--------------------------------------------------------------------------------
templateLocation::Text
templateLocation = "c:/Users/brent/toolcrib/templates/"
--------------------------------------------------------------------------------
connectionString::String
connectionString = "Driver={MySQL ODBC 8.0 Unicode Driver};\
                            \Server=192.168.0.3;Database=diam_oj;\
                            \Uid=root;Pwd=12thandEastman;"
--------------------------------------------------------------------------------
main :: IO ()
main = do
-- {-
    conn<-handleSqlError $ do
        conn <- connectODBC connectionString 
        return conn
    result<- quickQuery conn "Select * from tools" []
--    print $ "result: " ++ show result
 --   -}
--    conn<-catchSql connectDB (\e->print e)
    ----
    --

    let hc =  set hcInterpretedSplices defaultInterpretedSplices $
              hcInterpretedSplices .~ ("nullSplice" ## nullSplice) $ 
              hcInterpretedSplices .~ ("intSplice" ## intSplice 1) $ 
              hcTemplateLocations .~ [loadTemplates $ T.unpack templateLocation] $ 
              set hcNamespace "" emptyHeistConfig::HeistConfig ActionM

    eitherHc <- initHeist (hc::HeistConfig ActionM)
    let hSt = getState eitherHc
    ------
    scotty 3000 $ do
      get "/test/:word" $ do
        beam <- Scty.param "word"
        Scty.html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]    
    ----
      addroute GET "/" $ Scty.text "dammit, jim, I'm a doctor, not a haskell programmer"
      let result' = fmap (++ [SqlString"\n"]) result ::[[SqlValue]]
      let a = Prelude.concat result' :: [SqlValue]
      let b = fmap ((T.append "\t").fromSql) a :: [Text]
      let d = T.concat b :: Text
      addroute GET "/test2" $ Scty.text $ d
    ----
      addroute GET "/splice" $ do -- $ Scty.html $ TE.decodeUtf8 $ toLazyByteString bdr
--        liftAndCatchIO $ print ("heist templates: " ++ (show $templateNames hSt))
--        liftAndCatchIO $ print ("heist splices: " ++ (show $spliceNames hSt))
 --       maybBuilder<- renderTemplate hSt "test"
-- evalHeistT :: Monad m => HeistT n m a -> Node -> HeistState n -> m a
-- callTemplate :: Monad n	 => ByteString-> Splices (Splice n)-> HeistT n n Template	
        let ct = callTemplate "test" ("intSplice" ## intSplice 2)
        tst<-evalHeistT ct (TextNode "") hSt 
        let bdr = renderHtmlFragment UTF8 tst
 {-        
        bdr<- case maybBuilder of
            Just (buildr,mime)-> do
--                print $ "mimeType: " ++ BS.unpack mime
                return buildr
            Nothing -> return Bldr.empty
            -}
        Scty.html $ TE.decodeUtf8 $ toLazyByteString bdr
   --     Scty.html $ TE.decodeUtf8 $ toLazyByteString tst
      return ()
--------------------------------------------------------------------------------
nullSplice:: I.Splice ActionM
nullSplice = return $ renderHtmlNodes "<h1>NULL</h1>"
--------------------------------------------------------------------------------
intSplice:: Int -> I.Splice ActionM
intSplice i = return $ renderHtmlNodes $ toHtml $ h1 $ 
                string ("Int is : " ++ show i ++ " m'kay")
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










