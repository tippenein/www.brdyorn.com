{-# LANGUAGE OverloadedStrings #-}

module Main where

import Hakyll
import Data.Ord
import Data.List
import Data.Monoid
import Control.Arrow
import Control.Category

-- | Main entry point.
main :: IO ()
main = hakyll $ do

  match "templates/*" $ compile templateCompiler

  -- copy static assets
  let assets = ["imgs/*", "resume.pdf", "robots.txt", "favicon.ico"]
  match (foldr1 (.||.) assets) $ do
    route idRoute
    compile copyFileCompiler

  match "index.html" $ do
    route idRoute
    compile $ copyFileCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
  -- index route
  -- match "index" $ route $ idRoute
  -- create "index"
  -- route idRoute
  -- compile $ copyFileCompiler

  match "*.md" $ do
    route $ setExtension "html"
    compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls

  match "css/*" $ do
    route idRoute
    compile compressCssCompiler

  -- Render RSS feed
  -- match "rss.xml" $ route idRoute
  -- create "rss.xml" $
  --   requireAll_ "posts/*"
  --     >>> arr dateOrdered
  --     >>> arr reverse
  --     >>> renderRss feedConfiguration

-- | Sort pages by their date field.
-- dateOrdered :: [Page a] -> [Page a]
-- dateOrdered = sortBy (comparing (getField "date"))

feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
  { feedTitle = "Brady Ouren's home page feed."
  , feedDescription = "Brady Ouren's home page feed."
  , feedAuthorName = "Brady Ouren"
  , feedAuthorEmail = "bradyouren@gmail.com"
  , feedRoot = "http://brdyorn.com"
  }
