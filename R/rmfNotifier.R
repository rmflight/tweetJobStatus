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
#' constructs and checks tweets
#' 
#' given a userID, jobID, status text and datestring, constructs a tweet where the tweet
#' length is <= 140 characters, trimming the jobID as necessary to make everything fit.
#' 
#' @param userID the userID to tweet to
#' @param jobID text string identifying the job
#' @param jobStatus the job status
#' @param dateString the date string to add to the tweet
#' @param charAllow the number of characters allowed in a tweet (currently 140)
#' 
#' @return character string
constructTweet <- function(userID, jobID, jobStatus, dateString, charAllow = 140){
  nUser <- nchar(userID)
  nJob <- nchar(jobID)
  nStatus <- nchar(jobStatus)
  nDate <- nchar(dateString)
  
  totalChar <- nchar(userID) + nchar(jobID) + nchar(jobStatus) + nchar(dateString) + 3
  
  ellipsChar <- 5
  
  if (totalChar >= charAllow){
    nJobAllow <- charAllow - ellipsChar - nUser - nStatus - nDate - 5
    
    jobID <- paste(substring(jobID, 1, nJobAllow), " ...", sep = "")
  }
  
  return(paste(userID, jobID, jobStatus, dateString, sep = " "))
}