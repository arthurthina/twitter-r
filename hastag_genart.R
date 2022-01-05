library(rtweet)
library(tidyverse)
library(hrbrthemes)
library(tidytext)
library(viridis)

gen_twts <- search_tweets("#generativeart", n = 18000, include_rts = FALSE)
#pull hashtag
hash <- gen_twts %>% 
  unnest_tokens(hashtag, text, "tweets", to_lower = TRUE) %>%
  filter(str_detect(hashtag, "^#")) %>%
  count(hashtag, sort = TRUE) %>%
  top_n(15)

#plot the data
ggplot(hash, aes(x = reorder(hashtag, n), y = n, fill = hashtag)) +
  geom_col() +
  scale_y_continuous(breaks = seq(from = 0, to = 8000, by = 1000)) +
  scale_fill_viridis(discrete = TRUE, option = "D") +
  labs(y = "Tweets",
       x = "Hashtag",
       caption = "@arthurstats_") +
  coord_flip() +
  theme_ft_rc() +
  theme(legend.position = "none")
