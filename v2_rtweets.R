library(httr)
library(tidyverse)

bearer_token <- Sys.getenv("v2")
headers <- c(`Authorization` = sprintf('Bearer %s', bearer_token))

params = list(
  `query` = 'from:rstats_tweets',
  `max_results` = '100',
  `tweet.fields` = 'created_at,lang,conversation_id'
)

response <- httr::GET(url = 'https://api.twitter.com/2/tweets/search/recent', httr::add_headers(.headers = headers), query = params)


recent_search_body <-
  content(
    response,
    as = 'parsed',
    type = 'application/json',
    simplifyDataFrame = TRUE
  )

str(recent_search_body)

recent_search_body$data %>% 
  select(text, created_at) %>% 
  filter(str_detect(text, "fix"))
