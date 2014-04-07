{-# LANGUAGE OverloadedStrings #-}

module Main where

import Hakyll
import Data.List

-- | Main entry point.
main :: IO ()
main = hakyll $ do
  match "templates/*" $ compile templateCompiler

  match "css/*" $ do
    route idRoute
    compile compressCssCompiler

  match "imgs/*" $ do
    route idRoute
    compile copyFileCompiler

  match ("favicon.ico"
        .||. "404.html"
        .||. "imgs/*"
        .||. "robots.txt"
        .||. "resume.pdf") $ do
    route idRoute
    compile copyFileCompiler

  match "*.md" $ do
    route $ setExtension "html"
    compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls
