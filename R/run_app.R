#' @title Run Shiny App
#' @description Launches the Shiny app for climatic factors and ice cream party simulation.
#' @import shiny
#' @author Sofia Daza
#' @export
run_app <- function() {
  library(shiny)
  library(ggplot2)

  ui <- fluidPage(
    titlePanel("Climatic Factors and Ice Cream Party Simulation"),
    sidebarLayout(
      sidebarPanel(
        h3("City Configurations"),
        textInput("city1", "City 1", value = "Lausanne"),
        numericInput("simulations1", "Simulations for City 1", value = 10000, min = 100),
        selectInput("factor1", "Weather Factor for City 1", choices = c("Temperature (\u00B0C)" = "temp", "Humidity (%)" = "humidity", "Pressure (hPa)" = "pressure")),

        textInput("city2", "City 2", value = "Geneva"),
        numericInput("simulations2", "Simulations for City 2", value = 10000, min = 100),
        selectInput("factor2", "Weather Factor for City 2", choices = c("Temperature (\u00B0C)" = "temp", "Humidity (%)" = "humidity", "Pressure (hPa)" = "pressure")),

        textInput("city3", "City 3", value = "Zurich"),
        numericInput("simulations3", "Simulations for City 3", value = 10000, min = 100),
        selectInput("factor3", "Weather Factor for City 3", choices = c("Temperature (\u00B0C)" = "temp", "Humidity (%)" = "humidity", "Pressure (hPa)" = "pressure")),

        actionButton("simulate", "Run Simulation")
      ),
      mainPanel(
        h3("Results for Cities"),
        fluidRow(
          column(12, h4("City 1"), plotOutput("temperaturePlot1"), verbatimTextOutput("simulationSummary1"), plotOutput("volumeHistogram1"), plotOutput("surfaceAreaHistogram1")),
          column(12, h4("City 2"), plotOutput("temperaturePlot2"), verbatimTextOutput("simulationSummary2"), plotOutput("volumeHistogram2"), plotOutput("surfaceAreaHistogram2")),
          column(12, h4("City 3"), plotOutput("temperaturePlot3"), verbatimTextOutput("simulationSummary3"), plotOutput("volumeHistogram3"), plotOutput("surfaceAreaHistogram3"))
        )
      )
    )
  )

  server <- function(input, output, session) {
    observeEvent(input$simulate, {
      cities <- c(input$city1, input$city2, input$city3)
      simulation_counts <- c(input$simulations1, input$simulations2, input$simulations3)
      factors <- c(input$factor1, input$factor2, input$factor3)

      combined_data_list <- list()

      for (i in seq_along(cities)) {
        city <- cities[i]
        weather_data <- lookup_weather_data(city)

        if (!is.null(weather_data)) {
          combined_data <- data.frame(
            date = as.POSIXct(weather_data$list$dt, origin = "1970-01-01", tz = "UTC"),
            temp = weather_data$list$main.temp,
            humidity = weather_data$list$main.humidity / 100,
            pressure = weather_data$list$main.pressure,
            city = weather_data$city$name
          )
          combined_data_list[[city]] <- combined_data

          output[[paste0("temperaturePlot", i)]] <- renderPlot({
            ggplot(combined_data, aes(x = date, y = temp)) +
              geom_line(color = "blue") +
              labs(
                title = paste("Temperature Trend for", combined_data$city[1]),
                x = "Date",
                y = "Temperature (°C)"
              ) +
              theme_minimal()
          })

          output[[paste0("simulationSummary", i)]] <- renderPrint({
            cat("Weather data summary for", combined_data$city[1], "\n")
            cat("Temperature Range: ", range(combined_data$temp), "\n")
            cat("Average Humidity: ", mean(combined_data$humidity) * 100, "%\n")
          })
        } else {
          showNotification(paste("Weather data could not be retrieved for", city), type = "error")
        }
      }

      for (i in seq_along(cities)) {
        city <- cities[i]
        combined_data <- combined_data_list[[city]]

        if (!is.null(combined_data)) {
          results <- simulate_party_simple(simulation_counts[i], combined_data)

          output[[paste0("volumeHistogram", i)]] <- renderPlot({
            ggplot(data.frame(volume = results$total_volume), aes(x = volume)) +
              geom_histogram(bins = 50, fill = "blue", alpha = 0.6) +
              labs(
                title = paste("Volume Distribution for", city),
                x = "Volume (cm³)",
                y = "Frequency"
              ) +
              theme_minimal()
          })

          output[[paste0("surfaceAreaHistogram", i)]] <- renderPlot({
            ggplot(data.frame(surface_area = results$total_surface_area), aes(x = surface_area)) +
              geom_histogram(bins = 50, fill = "green", alpha = 0.6) +
              labs(
                title = paste("Surface Area Distribution for", city),
                x = "Surface Area (cm²)",
                y = "Frequency"
              ) +
              theme_minimal()
          })
        }
      }
    })
  }

  shinyApp(ui = ui, server = server)
}
