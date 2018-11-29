library(dplyr)
library(ggplot2)
install.packages("devtools")
library(devtools)
devtools::install_github('charlie86/spotifyr')
install.packages("spotifyr")
library(spotifyr)

Sys.setenv(SPOTIFY_CLIENT_ID = "198cd9a9951141fb95d68fe7203ba125")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "fbde10ed2bff4ec094ebed4caf805e2c")
access_token <- get_spotify_access_token()

hillsong_data <- get_artist_audio_features("Hillsong Worship")
godisable_data <- hillsong_data %>% filter(album_name == "God Is Able")
godisable_track_popularity <- godisable_data %>% select(track_name, track_popularity)
maroon5_data <- get_artist_audio_features("Maroon 5")
album_popularity <- get_album_popularity()

install.packages("ggplot2")

ggplot(godisable_track_popularity, aes(x=factor(1), fill=track_name))+
  geom_bar(width = 1)+
  coord_polar("y")

bp<- ggplot(godisable_track_popularity, aes(x="", y=track_popularity, fill=track_name))+
  geom_bar(width = 1, stat = "identity") +
  title("Popularity of Songs in Album")
bp
pie <- bp + coord_polar("y", start=0)
pie
