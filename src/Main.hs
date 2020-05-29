{-# LANGUAGE OverloadedStrings #-}
module Main where
import Control.Monad (forM_)
import Network.CGI as Cgi
import Text.Blaze.Html5 as H hiding (main)
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Utf8 as Hr
--import Text.Blaze.Html.Renderer.String as Hr
import Data.ByteString.Char8 (pack,unpack,ByteString,append)
--import Database.MySQL.Base
import Database.HDBC
import Database.HDBC.ODBC
--------------------------------------------------------------------------------
numbers::Int->Html
numbers n = docTypeHtml $ do
     H.head $ do
         H.title "Natural numbers"
     body $ do
         p "A list of natural numbers:"
         ul $ forM_ [1 .. n] (li . toHtml)
--------------------------------------------------------------------------------
cgiMain :: CGI CGIResult
cgiMain = do
    env<-getVars
    let envBS = showFormatted env
    Cgi.outputFPS $ Hr.renderHtml $ showEnvVars envBS
--------------------------------------------------------------------------------
showFormatted::[(String,String)]->[ByteString]
showFormatted [] = []
showFormatted (val:vals) = ((pack$ fst val) `append` "=" `append` 
            (pack$ snd val)):showFormatted vals
--------------------------------------------------------------------------------
showEnvVars::[ByteString]->Html
showEnvVars str = docTypeHtml $ do
     H.head $ do
         H.title "Environment Variables"
     body $ do
         p "CGI Environment Variables"
         ul $ forM_ str (li . toHtml . unpack)

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
    print result
--    runCGI $ handleErrors cgiMain
