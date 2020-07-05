{-# LANGUAGE OverloadedStrings #-}

module BlazeUtil where


import qualified Data.Text.Lazy as T
import qualified Heist.Interpreted as I
import           Text.Blaze.Html
import           Text.Blaze.Html5 as H
import           Text.Blaze.Html5.Attributes as A
import           Text.Blaze.Internal (MarkupM(..) , Attribute, AttributeValue, attribute)
import           Text.Blaze.Renderer.XmlHtml


------------------------------------------------------------------------------
blazeTable::[T.Text]->[[T.Text]]->H.Markup 
blazeTable headings rows = do
    H.div ! A.class_ "container" $ do
        H.table ! A.class_ "table table-hover" $ do
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
