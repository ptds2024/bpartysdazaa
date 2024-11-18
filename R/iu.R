#' @title UI for the Shiny App
#' @description User interface definition for the Ice Cream Party Simulation app.
#' @author Sofia Daza
#' @import shiny
#' @export
ui <- fluidPage(
  titlePanel("Climatic Factors and Ice Cream Party Simulation"),
  sidebarLayout(
    sidebarPanel(
      h3("City Configurations"),
      textInput("city1", "City 1", value = "Lausanne"),
      numericInput("simulations1", "Simulations for City 1", value = 10000, min = 100),
      selectInput("factor1", "Weather Factor for City 1", choices = c("Temperature (°C)" = "temp", "Humidity (%)" = "humidity", "Pressure (hPa)" = "pressure")),

      textInput("city2", "City 2", value = "Geneva"),
      numericInput("simulations2", "Simulations for City 2", value = 10000, min = 100),
      selectInput("factor2", "Weather Factor for City 2", choices = c("Temperature (°C)" = "temp", "Humidity (%)" = "humidity", "Pressure (hPa)" = "pressure")),

      textInput("city3", "City 3", value = "Zurich"),
      numericInput("simulations3", "Simulations for City 3", value = 10000, min = 100),
      selectInput("factor3", "Weather Factor for City 3", choices = c("Temperature (°C)" = "temp", "Humidity (%)" = "humidity", "Pressure (hPa)" = "pressure")),

      actionButton("simulate", "Run Simulation")
    ),
    mainPanel(
      h3("Results for Cities"),
      fluidRow(
        column(12, h4("City 1"), plotOutput("comparisonPlot1"), verbatimTextOutput("simulationSummary1"), plotOutput("volumeHistogram1"), plotOutput("surfaceAreaHistogram1"), plotOutput("temperaturePlot1")),
        column(12, h4("City 2"), plotOutput("comparisonPlot2"), verbatimTextOutput("simulationSummary2"), plotOutput("volumeHistogram2"), plotOutput("surfaceAreaHistogram2"), plotOutput("temperaturePlot2")),
        column(12, h4("City 3"), plotOutput("comparisonPlot3"), verbatimTextOutput("simulationSummary3"), plotOutput("volumeHistogram3"), plotOutput("surfaceAreaHistogram3"), plotOutput("temperaturePlot3"))
      )
    )
  )
)

