library(tidyverse)
library(stringr)
library(httr)
library(jsonlite)
library(knitr)
library(DT)


# schedule_url <- "http://fantasy.espn.com/apis/v3/flb"
# raw_schedule <- GET(url = schedule_url)
# raw_schedule_content <- rawToChar(raw_schedule$content)
# raw_schedule <- fromJSON(raw_schedule_content)

pitcher_2018_url <- "http://fantasy.espn.com/apis/v3/games/flb/seasons/2019/segments/0/leagues/133735?scoringPeriodId=0&view=kona_player_info"
raw_stats <- GET(url = pitcher_2018_url)
raw_stats_content <- rawToChar(raw_stats$content)
raw_stats <- fromJSON(raw_stats_content)

# get the first player's stats raw_stats$players$player$stats[1]
names(raw_stats$players$player$stats) <- raw_stats$players$player$fullName

# explore
raw_stats$players$player$stats %>% head()


