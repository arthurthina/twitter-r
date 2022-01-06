library(rtweet)
library(tidyr)
library(dplyr)
library(ggplot2)

genart_twts <- search_tweets("#generativeart", n = 18000, include_rts = FALSE)
genart_ts <- ts_data(genart_twts, by = "hours")
names(genart_ts) <- c("time", "#generativeart")
head(genart_ts)

#Check related hashtags
gen_twts <- search_tweets("#generative", n = 18000, include_rts = FALSE)
gen_ts <- ts_data(gen_twts, by = "hours")
names(gen_ts) <- c("time", "#generative")
head(gen_ts)

merged_df <- merge(gen_ts, genart_ts, by = "time", all = TRUE)
head(merged_df, 20)

longer_df <- pivot_longer(merged_df,
                          cols = -time,
                          names_to = "hashtag", 
                          values_to = "tweets_n")
str(longer_df)

ggplot(longer_df, aes(x = time, y = tweets_n, fill = hashtag)) +
  ##geom_col(position = "fill") +
  geom_col() +
  labs(x = "Date",
       y = "Tweets",
       fill = "Hashtag", 
       title = "Hashtag Comparison")

longer_df %>% group_by(hashtag) %>% 
  tally(tweets_n)
