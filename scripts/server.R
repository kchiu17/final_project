library('shiny')
library('dplyr')
library('ggplot2')
library('spotifyr')
source('keys.R')

Sys.setenv(SPOTIFY_CLIENT_ID = spotify.id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = spotify.client.secret)
access_token <- get_spotify_access_token()


server <- function(input, output) {
  
  data <- reactive ({
    return(get_artist_audio_features(input$artist))
  })
  
  output$plot <- renderPlot({
    artist_info <- data() %>%
      filter(tempo >= input$tempo[1], tempo <= input$tempo[2]) %>%
      filter(danceability >= input$danceability[1], 
             danceability <= input$danceability[2]) %>%
      filter(album_release_date >= input$album_release_date[1],
             album_release_date <= input$album_release_date[2]) %>%
      filter((duration_ms / 60000) >= input$duration[1],
             (duration_ms / 60000) <= input$duration[2])
    
    plot<-ggplot(artist_info, aes(x=track_name, y=track_popularity)) +
      geom_bar(stat="identity") + coord_flip()
    return(plot)
  })
}
shinyServer(server)