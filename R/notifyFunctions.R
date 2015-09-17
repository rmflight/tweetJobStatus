#' notifies job status
#' 
#' sends tweets to users about the job status
#' 
#' @param jobRun the function call to evaluate (default is empty function)
#' @param jobID text string to associate with job call
#' @param userID the users to notify as a character vector. See Details for more information.
#' @param addNow add current date-time to tweet text
#' @param testTweet if TRUE, print the tweets instead of actually tweeting them
#' 
#' @details To send the same tweet to multiple users separately, pass in a character
#'   vector of \code{userID}'s, in the form of \code{c("@userID1", "@userID2")}.
#'   A single tweet to multiple users can be done instead by supplying a \code{userID}
#'   of the form \code{"@userID1 @userID2"}.
#'   
#'   Note that the \code{jobID} will be truncated to make the text fit into Twitter's
#'   140 character limit. Also, setting \code{addNow = FALSE} is generally a bad idea
#'   because the time at second resolution makes the tweet text unique, which in turn
#'   will keep Twitter from blocking the tweets.
#' 
#' @export
#' @importFrom twitteR tweet
#' @importFrom lubridate now
jobNotify <- function(jobRun = function(){}, jobID, userID = "", addNow = TRUE, testTweet = FALSE){
  outData <- tryCatch(jobRun, 
                      error = function(c){
                        outData <- conditionMessage(c)
                        outData <- invisible(structure(outData, class = "job-error"))
                        return(outData)
                      })
  jobStatus <- "COMPLETED"
  
  if (class(outData) == "job-error"){
    jobStatus <- "ERRORED OUT"
  }
  
  t <- ""
  
  if (addNow){
    t <- now()
  }
  
  tweetTexts <- vapply(userID, constructTweet, character(1), jobID, jobStatus, t)
  
  if (!testTweet){
    lapply(tweetTexts, tweet)
  } else {
    lapply(tweetTexts, print)
  }
  
  if (class(outData) == "job-error"){
    message(outData)
  } else {
    return(outData)
  }
}

#' notify after
#' 
#' Instead of wrapping the function call into the tweet notify call, call it after
#' and check for any errors using \code{geterrmessage}.

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