# Tweet R Job Status

This package enables the user to use a Twitter app to send job notification updates. See [this post](http://rmflight.github.io/posts/2014/06/r_job_notifications_twitter.html) for the original incarnation.

## WARNING

Dont EVER, EVER, EVER commit the `data/local_cache.RData` file that gets created below. This file is listed in the `.gitignore` file, which is actually included in this *git* repo for a reason. If someone gets ahold of your `oauth` cache, they can then tweet from your app. This is largely why I recommend creating a separate user and app to tweet from, and *NOT* associate credentials with your own twitter profile.

## Installation

This is a little different, because it depends on caching **oauth** credentials and storing them as part of the package itself, so it is a little bit more complicated.

### Install twitteR & devtools Package

```
install.packages(c("devtools", "twitteR"))
```

### Clone tweetJobStatus

```
git clone https://github.com/rmflight/tweetJobStatus.git
```

### Create Twitter App

We are going to create a `twitter` *account* and *app* specifically for sending this one type of notification. You can register a new `twitter` account using a new email (if you use `gmail` you can add a dot (.) anywhere in your email address for a unique address that still reaches you) and setup a new user name. 

After setting up your new account, log in to https://apps.twitter.com, and `create new app`. Fill in all the necessary details, and when you have it up, `modify app permissions` to be `Read and write`. This will allow it to actually send messages on the accounts behalf.

### App Credentials

Click on the `API Keys` tab, and set up your api data by copying the values into the code below. Note if you dont see a token and a secret, try hitting `test oauth` to generate one.

*All following steps should be done in `R`.*

```
apikey <- "" #API Key
apisecret <- "" #API Secret
token <- "" #Access Token
tokensecret <- "" #Access token secret
```

And now we will authorize our app and make sure that it can tweet.

```
library(twitteR)
setup_twitter_oauth(apikey, apisecret, token, tokensecret)
tweet("this is a test") # make sure you can see a tweet
tweet("@youruserid this is a test") # check that you see notifications, change @youruserid to your own twitter handle
```

And then save the cache for later use.

```
local_cache <- get("oauth_token", twitteR:::oauth_cache) # saves the oauth token so we can reuse it
save(local_cache, file="data/oauth_cache.RData")
```

### Install With Saved Credentials and Test Again

```
devtools::install() # or Build & Reload
tweetJobStatus::jobNotify(jobID = "test", userID = "@youruserid")

testFunction <- function(x){
  stopifnot(!is.null(x))
  x
}

tweetJobStatus::jobNotify(testFunction(NULL), "test null", "@youruserid")
tweetJobStatus::jobNotify(testFunction(1), "test null", "@youruserid")
```

You can also add an argument `testTweet = TRUE` to see what the output looks like without actually sending tweets.

## Make @youruserid Default

You may also want to modify the `jobNotify` function so that your twitter handle is the default. Simply modify `notifyFunctions.R`, and change `userID = ""` to `userID = "@youruserid"`.