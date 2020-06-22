{-# LANGUAGE OverloadedStrings #-}
module Main where
import Control.Monad (forM_)
import Text.Blaze.Html5 as H hiding (main)
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Utf8 as Hr
--import Text.Blaze.Html.Renderer.String as Hr
import Data.ByteString.Char8 (pack,unpack,ByteString,append)
import Database.HDBC
import Database.HDBC.ODBC
import Web.Scotty as Scty
import Data.Monoid (mconcat)
import Heist
import Heist.Interpreted 
import Network.HTTP.Types
import Data.Text.Lazy as T
import Data.HashMap.Strict as Hash
import Lens.Simple as L
--------------------------------------------------------------------------------
templateLocation::Text
templateLocation = "c:/Users/brent/toolcrib/templates/"
--------------------------------------------------------------------------------
main :: IO ()
main = do

    let connectionString = "Driver={MySQL ODBC 8.0 Unicode Driver};\
                            \Server=192.168.0.3;Database=diam_oj;\
                            \Uid=root;Pwd=12thandEastman;"

    conn<-handleSqlError $ do
        conn <- connectODBC connectionString 
        return conn
    result<- quickQuery conn "Select * from tools" []
    --loadTemplates :: FilePath -> IO (Either [String] TemplateRepo)
    --type TemplateLocation = IO (Either [String] TemplateRepo)
    --hcTemplateLocations :: Functor f => ([TemplateLocation] -> f [TemplateLocation]) -> HeistConfig m -> f (HeistConfig m)
    --trepo <- loadTemplates $ T.unpack templateLocation
    --  case trepo of
    --      Right r -> do 
    --          print $ "hash size: " ++ show (Hash.size r)
    --          return ()
    --      Left l -> print $ "warning: " ++ (show l)

    let hc = set hcNamespace "" emptyHeistConfig
    --let hc2 = set hcTemplateLocations [loadTemplates $ T.unpack templateLocation] hc
    let hc2 = hcTemplateLocations .~ [loadTemplates $ T.unpack templateLocation] $ hc
    heistResult <-initHeist (hc2::HeistConfig IO)
    let st = getState heistResult
    print ("heist state: " ++ (show $templateNames st))
    scotty 3000 $ do
      get "/test/:word" $ do
        beam <- Scty.param "word"
        Scty.html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]    
      addroute GET "/" $ Scty.text "dammit, jim, I'm a doctor, not a haskell programmer"
--      let c = fmap (b  (T.snoc "\n")) :: [Text]
--      let e =  SqlString "\n"::SqlValue
      let result' = fmap (++ [SqlString"\n"]) result ::[[SqlValue]]
      let a = Prelude.concat result' :: [SqlValue]
      let b = fmap ((T.append "\t").fromSql) a :: [Text]
      let d = T.concat b :: Text
      addroute GET "/test2" $ Scty.text $ d
      return ()

--------------------------------------------------------------------------------
getState::(Either [String] (HeistState IO))->HeistState IO
getState hs= do
     case hs of
        Right r->r
        Left s -> error $ show s












