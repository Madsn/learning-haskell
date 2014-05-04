module Paths_snap_test (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "D:\\repo\\learning-haskell\\exercises\\snap\\.cabal-sandbox\\bin"
libdir     = "D:\\repo\\learning-haskell\\exercises\\snap\\.cabal-sandbox\\i386-windows-ghc-7.6.3\\snap-test-0.1"
datadir    = "D:\\repo\\learning-haskell\\exercises\\snap\\.cabal-sandbox\\i386-windows-ghc-7.6.3\\snap-test-0.1"
libexecdir = "D:\\repo\\learning-haskell\\exercises\\snap\\.cabal-sandbox\\snap-test-0.1"
sysconfdir = "D:\\repo\\learning-haskell\\exercises\\snap\\.cabal-sandbox\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "snap_test_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "snap_test_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "snap_test_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "snap_test_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "snap_test_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
