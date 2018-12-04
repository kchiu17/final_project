library("shiny")
library('plotly')

choices <- c(0,1,2,3,4,5,"5+")
ui <- fluidPage(
  titlePanel("Spotify Me!"),
  h4("Made by Team BA6 with no Brian"),
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
      div(style="display: inline-block;vertical-align:top; width: 150px; text-align: left",
      selectInput("x", "X-axis", c("Track Popularity", "Album Release Date", "Danceability", "Instrumentalness", "Tempo", "Duration ms"),
                  selected="Tempo", multiple=FALSE)),
      div(style="display: inline-block;vertical-align:top; width: 150px; align-items: right",
      selectInput("y", "Y-axis", c("Track Popularity", "Album Release Date", "Danceability", "Instrumentalness", "Tempo", "Duration ms"),
                  selected="Danceability", multiple=FALSE)),        
      textOutput("title"),
      plotlyOutput("plot")
      )
    )
  )
shinyUI(ui)