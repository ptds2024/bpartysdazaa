#' @title Server for the Shiny App
#' @description Server logic for the Ice Cream Party Simulation app.
#' @author Sofia Daza
#' @export
server <- function(input, output, session) {
  observeEvent(input$simulate, {
    cities <- c(input$city1, input$city2, input$city3)
    simulation_counts <- c(input$simulations1, input$simulations2, input$simulations3)
    factors <- c(input$factor1, input$factor2, input$factor3)

    for (i in seq_along(cities)) {
      city <- cities[i]
      sim_count <- simulation_counts[i]
      selected_factor <- factors[i]
      output_suffix <- as.character(i)

      weather_data <- lookup_weather_data(city)

      if (!is.null(weather_data)) {
        forecast_list <- weather_data$list
        combined_data <- data.frame(
          date = as.POSIXct(forecast_list$dt, origin = "1970-01-01", tz = "UTC"),
          temp = forecast_list$main.temp,
          humidity = forecast_list$main.humidity / 100,
          pressure = forecast_list$main.pressure,
          city = city
        )

        results <- simulate_party_simple(sim_count, combined_data)

        local({
          city <- city
          combined_data <- combined_data
          results <- results
          selected_factor <- selected_factor

          output[[paste0("comparisonPlot", output_suffix)]] <- renderPlot({
            factor_label <- switch(selected_factor,
                                   temp = "Temperature (°C)",
                                   humidity = "Humidity (%)",
                                   pressure = "Pressure (hPa)"
            )

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
        })
      } else {
        showNotification(paste("Weather data could not be retrieved for", city), type = "error")
      }
    }
  })
}
