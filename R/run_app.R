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
          column(12, h4("City 1"), plotOutput("comparisonPlot1"), verbatimTextOutput("simulationSummary1"), plotOutput("volumeHistogram1"), plotOutput("surfaceAreaHistogram1")),
          column(12, h4("City 2"), plotOutput("comparisonPlot2"), verbatimTextOutput("simulationSummary2"), plotOutput("volumeHistogram2"), plotOutput("surfaceAreaHistogram2")),
          column(12, h4("City 3"), plotOutput("comparisonPlot3"), verbatimTextOutput("simulationSummary3"), plotOutput("volumeHistogram3"), plotOutput("surfaceAreaHistogram3"))
        )
      )
    )
  )

  server <- function(input, output, session) {
    observeEvent(input$simulate, {
      cities <- c(input$city1, input$city2, input$city3)
      simulation_counts <- c(input$simulations1, input$simulations2, input$simulations3)
      factors <- c(input$factor1, input$factor2, input$factor3)

      for (i in seq_along(cities)) {
        local({
          city <- cities[i]
          sim_count <- simulation_counts[i]
          selected_factor <- factors[i]
          output_suffix <- as.character(i)

          weather_data <- lookup_weather_data(city)

          if (!is.null(weather_data)) {
            combined_data <- data.frame(
              date = as.POSIXct(weather_data$list$dt, origin = "1970-01-01", tz = "UTC"),
              temp = weather_data$list$main.temp,
              humidity = weather_data$list$main.humidity / 100,
              pressure = weather_data$list$main.pressure,
              city = weather_data$city$name
            )

            results <- simulate_party_simple(sim_count, combined_data)

            output[[paste0("comparisonPlot", output_suffix)]] <- renderPlot({
              factor_label <- switch(selected_factor,
                                     temp = "Temperature (\u00B0C)",
                                     humidity = "Humidity (%)",
                                     pressure = "Pressure (hPa)")

              ggplot(combined_data, aes(x = date, y = .data[[selected_factor]])) +
                geom_line(color = "blue") +
                labs(
                  title = paste(factor_label, "Trend for", city),
                  x = "Date",
                  y = factor_label
                ) +
                theme_minimal()
            })

            output[[paste0("simulationSummary", output_suffix)]] <- renderPrint({
              cat("Results for", city, "\n")
              cat("Mean Volume (cm³):", round(results$mean_volume, 2), "\n")
              cat("SD Volume (cm³):", round(results$sd_volume, 2), "\n")
              cat("99th Percentile Volume (cm³):", round(results$volume_99, 2), "\n")
              cat("Mean Surface Area (cm²):", round(results$mean_surface_area, 2), "\n")
              cat("SD Surface Area (cm²):", round(results$sd_surface_area, 2), "\n")
              cat("99th Percentile Surface Area (cm²):", round(results$surface_area_99, 2), "\n")
            })

            output[[paste0("volumeHistogram", output_suffix)]] <- renderPlot({
              ggplot(data.frame(volume = results$total_volume), aes(x = volume)) +
                geom_histogram(bins = 50, fill = "blue", alpha = 0.6) +
                labs(
                  title = paste("Volume Distribution for", city),
                  x = "Volume (cm³)",
                  y = "Frequency"
                ) +
                theme_minimal()
            })

            output[[paste0("surfaceAreaHistogram", output_suffix)]] <- renderPlot({
              ggplot(data.frame(surface_area = results$total_surface_area), aes(x = surface_area)) +
                geom_histogram(bins = 50, fill = "green", alpha = 0.6) +
                labs(
                  title = paste("Surface Area Distribution for", city),
                  x = "Surface Area (cm²)",
                  y = "Frequency"
                ) +
                theme_minimal()
            })
          } else {
            showNotification(paste("Weather data could not be retrieved for", city), type = "error")
          }
        })
      }
    })
  }

  shinyApp(ui = ui, server = server)
}
