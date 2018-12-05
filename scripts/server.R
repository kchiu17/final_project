library('shiny')
library('dplyr')
library('ggplot2')
library('spotifyr')
library('stringr')
library('plotly')
library('tools')
source('keys.R')

Sys.setenv(SPOTIFY_CLIENT_ID = spotify.id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = spotify.client.secret)
access_token <- get_spotify_access_token()


server <- function(input, output) {
  
  # Returns a data frame of the input artist
  data <- reactive ({
    return(get_artist_audio_features(input$artist))
  })
  
  # Turns the textbox selection into a column name that is useable from the spotify api
  axis_key_conversion_x <- reactive ({
    worse_version <- str_replace_all(input$x, " ", "_")
    worst_version <- tolower(worse_version)
    return(worst_version)
  })

  axis_key_conversion_y <- reactive ({
    worse_version <- str_replace_all(input$y, " ", "_")
    worst_version <- tolower(worse_version)
    return(worst_version)
  })  
  
  # Plots tracks filtered by tempo, danceability, album release date, and duration
  output$plot <- renderPlotly({
    artist_info <- data() %>%
      filter(tempo >= input$tempo[1], tempo <= input$tempo[2]) %>%
      filter(danceability >= input$danceability[1], 
             danceability <= input$danceability[2]) %>%
      filter(album_release_date >= input$album_release_date[1],
             album_release_date <= input$album_release_date[2]) %>%
      filter((duration_ms / 60000) >= input$duration[1],
             (duration_ms / 60000) <= input$duration[2])
    
    input_x <- rlang::sym(axis_key_conversion_x())
    input_y <- rlang::sym(axis_key_conversion_y())
    
    plot<-ggplot(artist_info, aes(x=!!input_x, y=!!input_y)) +
      scale_shape_discrete(solid = F) +
      geom_point(aes(text = track_name, size = track_popularity), color = "red", alpha = 1/2) + 
      theme_bw() + xlab(input$x) + ylab(input$y) 
    plot <- ggplotly(plot)
    return(plot)
  })
  
  # Creates a title for the plot with specified variables by the user
  output$title <- renderText({
    paste("Plot of ", input$x, " vs ", input$y, " of ", input$artist, "'s Songs", sep="")
  })
}
shinyServer(server)