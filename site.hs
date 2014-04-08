{-# LANGUAGE OverloadedStrings #-}

module Main where

import Hakyll
import Data.Ord
import Data.List
import Data.Monoid
import Control.Arrow

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

  match "*.md" $ do
    route $ setExtension "html"
    compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls

  match "css/*" $ do
    route idRoute
    compile compressCssCompiler

  tags <- buildTags "posts/*" $ fromCapture "tags/*.html"
  match "posts/*" $ do
      route $ setExtension "html"
      compile $ pandocCompiler
          >>= loadAndApplyTemplate "templates/post.html" (taggedPostCtx tags)
          >>= saveSnapshot "content"
          >>= loadAndApplyTemplate "templates/default.html" postCtx
          >>= relativizeUrls

  create ["posts.html"] $ do
    route idRoute
    compile $ do
      let archiveCtx =
              field "posts" (const $ postList recentFirst) `mappend`
              constField "title" "Posts" `mappend`
              defaultContext
      makeItem ""
          >>= loadAndApplyTemplate "templates/posts.html" archiveCtx
          >>= loadAndApplyTemplate "templates/default.html" archiveCtx
          >>= relativizeUrls

  create ["rss.xml"] $ do
    route idRoute
    compile $ do
      let feedCtx = postCtx `mappend`
              constField "description" "This is the post description"
      posts <- fmap (take 10) . recentFirst =<< loadAll "posts/*"
      renderRss myFeedConfiguration feedCtx posts

myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
  { feedTitle = "Brady Ouren's home page feed."
  , feedDescription = "Brady Ouren's home page feed."
  , feedAuthorName = "Brady Ouren"
  , feedAuthorEmail = "bradyouren@gmail.com"
  , feedRoot = "http://brdyorn.com"
  }

postList :: ([Item String] -> Compiler [Item String]) -> Compiler String
postList sortFilter = do
  posts <- sortFilter =<< loadAll "posts/*"
  itemTpl <- loadBody "templates/post-item.html"
  list <- applyTemplateList itemTpl postCtx posts
  return list

taggedPostCtx :: Tags -> Context String
taggedPostCtx tags = tagsField "tags" tags `mappend` postCtx

postCtx :: Context String
postCtx = dateField "date" "%B %e, %Y" `mappend` defaultContext
