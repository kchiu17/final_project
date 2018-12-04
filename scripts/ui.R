library("shiny")
library('plotly')

ui <- fluidPage(
  titlePanel("Spotify Me!"),
  h4("Made by Team BA6"),
  sidebarLayout(
    sidebarPanel(
      textInput("artist", "Input Artist Here", "Taylor Swift"),
      dateRangeInput("album_release_date", "Date Released", start=Sys.Date()-1825
                     , end=Sys.Date(), format = "yyyy-mm-dd"),      
      sliderInput("tempo", "Tempo", 0, 200, c(80,120), step=10),
      sliderInput("danceability", "Danceability", 0, 1, c(0.5,0.7), step=0.05),
      sliderInput("duration", "Duration (minutes)", 0, 10, c(2,5), step=.25)
      ),
    mainPanel(
      div(style="text-align:center;",
      h4("Change Axis Data")),
      div(style="display: inline-block;vertical-align:top; width: 150px; margin-right: 35em;",
      selectInput("x", "X-axis", c("Track Popularity", "Album Release Date", "Danceability", "Instrumentalness", "Tempo", "Duration ms"),
                  selected="Tempo", multiple=FALSE)),
      div(style="display:inline-block;vertical-align:top; width: 150px;",
      selectInput("y", "Y-axis", c("Track Popularity", "Album Release Date", "Danceability", "Instrumentalness", "Tempo", "Duration ms"),
                  selected="Danceability", multiple=FALSE)),        
      div(style="text-align: center;font-size:1.5em;margin-bottom: 10px;",textOutput("title")),
      plotlyOutput("plot")
      )
    )
  )
shinyUI(ui)