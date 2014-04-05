{-# LANGUAGE OverloadedStrings #-}

module Main where

import Hakyll
import Data.List

-- | Main entry point.
main :: IO ()
main = hakyll $ do
  match "posts/*" $ do
    route   $ setExtension ""
    compile $ pageCompiler

  match "stylesheets/" $ do
    route idRoute
    compile compressCssCompiler

