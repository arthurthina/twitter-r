library(rtweet)
library(tidyr)
library(ggplot2)
library(lubridate)

genart_twts <- search_tweets("#generativeart", n = 18000, include_rts = FALSE)
genart_ts <- ts_data(genart_twts, by = "hours")
names(genart_ts) <- c("time", "#generativeart")
head(genart_ts)


gen_twts <- search_tweets("#generative", n = 18000, include_rts = FALSE)
gen_ts <- ts_data(gen_twts, by = "hours")
names(gen_ts) <- c("time", "#generative")
head(gen_ts)

merged_df <- merge(gen_ts, genart_ts, by = "time", all = TRUE)
head(merged_df)

longer_df <- pivot_longer(merged_df,
                          cols = -time,
                          names_to = "hashtag", 
                          values_to = "tweets_n")


ggplot(longer_df, aes(x = time, y = tweets_n, col = hashtag)) +
  geom_line(lwd = 0.6) +
  labs(x = "Date",
       y = "Tweets",
       fill = "Hashtag", 
       title = "Hashtag Comparison")
