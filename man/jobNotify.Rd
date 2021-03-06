% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/notifyFunctions.R
\name{jobNotify}
\alias{jobNotify}
\title{notifies job status}
\usage{
jobNotify(jobRun = function() { }, jobID, userID = "", addNow = TRUE,
  testTweet = FALSE)
}
\arguments{
\item{jobRun}{the function call to evaluate (default is empty function)}

\item{jobID}{text string to associate with job call}

\item{userID}{the users to notify as a character vector. See Details for more information.}

\item{addNow}{add current date-time to tweet text}

\item{testTweet}{if TRUE, print the tweets instead of actually tweeting them}
}
\description{
sends tweets to users about the job status
}
\details{
To send the same tweet to multiple users separately, pass in a character
vector of \code{userID}s, in the form of \code{c("userID1", "userID2")}.
A single tweet to multiple users
can be done instead by supplying a \code{userID} of the form \code{("userID1 userID2")}.
Note that the \code{jobID} will be truncated to make the text fit into Twitter's
140 character limit. Also, setting \code{addNow = FALSE} is generally a bad idea
because the time at second resolution makes the tweet text unique, which in turn
will keep Twitter from blocking the tweets.
}

