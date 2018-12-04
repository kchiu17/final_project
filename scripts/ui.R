library("shiny")

ui <- fluidPage(
  titlePanel("Spotify Me!"),
  h4("Made by the Team"),
  sidebarLayout(
    sidebarPanel(
      textInput("artist", "Input Artist Here", "Taylor Swift"),
      dateRangeInput("album_release_date", "Date Released", start=Sys.Date()-1825
                     , end=Sys.Date(), format = "yyyy-mm-dd"),      
      sliderInput("tempo", "Tempo", 0, 200, c(80,100), step=10),
      sliderInput("danceability", "Danceability", 0, 1, c(0.5,0.6), step=0.05),
      sliderInput("duration", "Duration (minutes)", 0, 10, c(2,3), step=.25)
      
      ),
    mainPanel(
      div(style="text-align:center;font-size:1.8em", textOutput("title_graph")),
      plotOutput("plot")
      )
    )
  )
shinyUI(ui)