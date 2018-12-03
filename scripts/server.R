library('shiny')
library('dplyr')
library('ggplot2')
library('spotifyr')
source('keys.R')

Sys.setenv(SPOTIFY_CLIENT_ID = spotify.id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = spotify.client.secret)
access_token <- get_spotify_access_token()


server <- function(input, output) {
  output$plot <- renderPlot({
    d <- get_artist_audio_features(input$artist)
    plot<-ggplot(d, aes(x=track_name, y=track_number)) +
      geom_bar(stat="identity")
    return(plot)
  })
}
shinyServer(server)