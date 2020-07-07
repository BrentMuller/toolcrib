{-# LANGUAGE OverloadedStrings #-}

module BlazeUtil where


--import qualified Data.Text.Lazy as T
import qualified Data.Text as T
import qualified Heist.Interpreted as I
import           Text.Blaze
import           Text.Blaze.Html
import           Text.Blaze.Html5 as H
import           Text.Blaze.Html5.Attributes as A
import           Text.Blaze.Internal (MarkupM(..) , Attribute, AttributeValue, attribute)
import           Text.Blaze.Renderer.XmlHtml


------------------------------------------------------------------------------
blazeTable::[T.Text]->[[T.Text]]->H.Markup 
blazeTable headings rows = do
    H.div ! A.class_ "container" $ do
        H.table ! A.class_ "table table-bordered table-hover" $ do
            H.thead ! A.class_ "thead-dark"$ do
                    blazeTableHeadings headings
                    blazeTableRows rows 
------------------------------------------------------------------------------
blazeTableHeadings::[T.Text]->H.Markup 
blazeTableHeadings textList = do
    H.tr $ do
        blazeTableHeadings' textList 
    where
    blazeTableHeadings' [] = Empty ()
    blazeTableHeadings' (x:xs) = do
        H.th $ toHtml x 
        blazeTableHeadings' xs
------------------------------------------------------------------------------
blazeTableRows::[[T.Text]]->H.Markup 
blazeTableRows [] =  Empty ()
blazeTableRows (x:xs) = do
    blazeTableRow x
    blazeTableRows xs
------------------------------------------------------------------------------
blazeTableRow::[T.Text]->H.Markup 
blazeTableRow textList = do
    H.tr $ do
        blazeTableRow' textList
        where
        blazeTableRow' [] = Empty ()
        blazeTableRow' (x:xs) = do
            H.td $ toHtml x 
            blazeTableRow' xs
------------------------------------------------------------------------------
bootStrapWarn::T.Text->Html
bootStrapWarn msg = do
        H.div H.! A.class_ "container" $ do
            H.div H.! A.class_ "alert alert-warning alert-dismissable fade show" $ do
                H.button H.! A.class_ "close" H.! dataAttribute "dismiss" "alert"
                         H.! A.type_ "button" $ "&times"
                H.strong "  Warning!  "
                toHtml msg
--------------------------------------------------------------------------------
blazeDataList::T.Text->[T.Text]->H.Markup
blazeDataList _ []  =  Empty ()
blazeDataList listId textList = do 
   H.datalist ! A.id (textValue listId) $ do
        blazeTableDataList textList 
    where
    blazeTableDataList [] = Empty ()
    blazeTableDataList (x:xs) = do
        H.option ! A.value  (textValue x) $ toHtml x
        blazeTableDataList xs
--------------------------------------------------------------------------------
