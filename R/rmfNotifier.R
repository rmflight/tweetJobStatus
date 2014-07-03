#' notifies job status
#' 
#' sends a tweet to rmflight the job status
#' 
#' @param tweetText the text to include in the tweet
#' @export
#' @importFrom twitteR tweet
#' @importFrom lubridate now
jobNotify <- function(tweetText, addnow=TRUE){
  t <- ""
  if (addnow){
    t <- now()
  }
  fullTweet <- paste("@rmflight", tweetText,  t, sep=" ")
  tweet(fullTweet)
}