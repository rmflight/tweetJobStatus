## ----eval=FALSE----------------------------------------------------------
#  library(devtools)
#  install_github('twitteR', username='goeffjentry')

## ----setupAPI, eval=FALSE------------------------------------------------
#  apikey <- "" #API Key
#  apisecret <- "" #API Secret
#  token <- "" #Access Token
#  tokensecret <- "" #Access token secret

## ----authorizeApp, eval=FALSE--------------------------------------------
#  library(twitteR)
#  setup_twitter_oauth(apikey, apisecret, token, tokensecret)
#  tweet("this is a test") # make sure you can see a tweet
#  tweet("@username this is a test") # check that you see notifications, change @username to your own username

## ----savecache, eval=FALSE-----------------------------------------------
#  local_cache <- get("oauth_tken", twitteR:::oauth_cache) # saves the oauth token so we can reuse it
#  save(local_cache, file="data/oauth_cache.RData")

## ----resetCache, eval=FALSE----------------------------------------------
#  .onLoad <- function(libname, pkgname){
#    cachedToken <- new.env()
#    dataFile <- system.file("data/oauth_cache.RData", package="packageName")
#    load(dataFile, cachedToken)
#    assign("oauth_token", cachedToken$local_cache, envir=twitteR:::oauth_cache)
#    rm(cachedToken)
#  }

## ----notifyFunction, eval=FALSE------------------------------------------
#  #' notifies job status
#  #'
#  #' sends a tweet to rmflight the job status
#  #'
#  #' @param tweetText the text to include in the tweet
#  #' @export
#  #' @importFrom twitteR tweet
#  jobNotify <- function(tweetText){
#    fullTweet <- paste("@username", tweetText, sep=" ") # change @username to where you want to recieve notifications
#    tweet(fullTweet)
#  }

## ----testit, eval=FALSE--------------------------------------------------
#  library(packageName) # change to the name of your own package
#  jobNotify("this is a test")

