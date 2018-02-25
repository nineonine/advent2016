{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_advent2016 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/nineonine/Programming/Haskell/advent2016/.stack-work/install/x86_64-osx/lts-8.15/8.0.2/bin"
libdir     = "/Users/nineonine/Programming/Haskell/advent2016/.stack-work/install/x86_64-osx/lts-8.15/8.0.2/lib/x86_64-osx-ghc-8.0.2/advent2016-0.1.0.0"
dynlibdir  = "/Users/nineonine/Programming/Haskell/advent2016/.stack-work/install/x86_64-osx/lts-8.15/8.0.2/lib/x86_64-osx-ghc-8.0.2"
datadir    = "/Users/nineonine/Programming/Haskell/advent2016/.stack-work/install/x86_64-osx/lts-8.15/8.0.2/share/x86_64-osx-ghc-8.0.2/advent2016-0.1.0.0"
libexecdir = "/Users/nineonine/Programming/Haskell/advent2016/.stack-work/install/x86_64-osx/lts-8.15/8.0.2/libexec"
sysconfdir = "/Users/nineonine/Programming/Haskell/advent2016/.stack-work/install/x86_64-osx/lts-8.15/8.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "advent2016_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "advent2016_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "advent2016_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "advent2016_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "advent2016_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "advent2016_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
