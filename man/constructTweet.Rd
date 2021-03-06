% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/notifyFunctions.R
\name{constructTweet}
\alias{constructTweet}
\title{notify after}
\usage{
constructTweet(userID, jobID, jobStatus, dateString, charAllow = 140)
}
\arguments{
\item{userID}{the userID to tweet to}

\item{jobID}{text string identifying the job}

\item{jobStatus}{the job status}

\item{dateString}{the date string to add to the tweet}

\item{charAllow}{the number of characters allowed in a tweet (currently 140)}
}
\value{
character string
}
\description{
Instead of wrapping the function call into the tweet notify call, call it after
and check for any errors using \code{geterrmessage}.
constructs and checks tweets
}
\details{
given a userID, jobID, status text and datestring, constructs a tweet where the tweet
length is <= 140 characters, trimming the jobID as necessary to make everything fit.
}

