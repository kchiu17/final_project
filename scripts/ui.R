library("shiny")

ui <- fluidPage(
  titlePanel("Spotify Me!"),
  h4("Made by the Team"),
  sidebarLayout(
    sidebarPanel(
      textInput("artist", "Input Artist Here")
      ),
    mainPanel(
      div(style="text-align:center;font-size:1.8em", textOutput("title_graph")),
      plotOutput("plot")
      )
    )
  )
shinyUI(ui)