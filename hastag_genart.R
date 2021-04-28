# Hello twitter

library(rtweet)
library(tidyverse)
library(hrbrthemes)
library(tidytext)
library(RColorBrewer)
library(scales)

gen_twts <- search_tweets("#generative", n = 18000, include_rts = FALSE)

hash <- gen_twts %>% 
  unnest_tokens(hashtag, text, "tweets", to_lower = TRUE) %>%
  filter(str_detect(hashtag, "^#")) %>%
  count(hashtag, sort = TRUE) %>%
  top_n(15)

colourCount = length(unique(hash$hashtag))
getPalette = colorRampPalette(brewer.pal(9, "Set2"))

p <- ggplot(hash, aes(x = reorder(hashtag, n), y = n, fill = hashtag)) +
  geom_col() +
  scale_fill_manual(values = getPalette(colourCount)) +
  scale_y_continuous(breaks = seq(from = 0, to = 1500, by = 250)) +
  labs(y = "Tweets",
       x = "Hashtag",
       title = "Top 15 hashtags related to #Generative on Twitter",
       subtitle = "(2020/09/07 - 2020/09/16)",
       caption = "@arthurstats_") +
  coord_flip() +
  theme_ft_rc() 

p + theme(legend.position = "none")
