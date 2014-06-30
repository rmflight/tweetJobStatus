#' notifies job status
#' 
#' sends a tweet to rmflight the job status
#' 
#' @param tweetText the text to include in the tweet
#' @export
#' @importFrom twitteR tweet
jobNotify <- function(tweetText){
  fullTweet <- paste("@rmflight", tweetText, sep=" ")
  tweet(fullTweet)
}