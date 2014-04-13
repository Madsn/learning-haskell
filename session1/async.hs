import Control.Concurrent.Async
import Network.HTTP

getURL url = simpleHTTP (getRequest url) >>= getResponseBody
url1 = "http://www.google.com"
url2 = "http://www.yahoo.com"

main =do
    a1 <- async (getURL url1)
    a2 <- async (getURL url2)
    page1 <- wait a1
    page2 <- wait a2
    print . length $ page1
    print . length $ page2
