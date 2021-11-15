import System.Environment
import Data.List (isPrefixOf)
import Control.Error.Safe (assertMay)

import qualified Prelude as P
import Relude

help = return ()

rootFilePath = "/home/lukas/projects/zettelkasten"
websiteRoot = "http://localhost:8000"

findNotePath :: Maybe String -> Maybe FilePath
findNotePath mPath = do
  path <- mPath
  assertMay $ isPrefixOf rootFilePath path
  let relPath = drop (length rootFilePath) path
  let relDPath = take ((length relPath) - 3) relPath
  return $ websiteRoot ++ relDPath ++ ".html"


main = do
  args <- getArgs
  let arg =  viaNonEmpty head args
  let notePath = findNotePath arg
  maybe help putStr notePath

