#' @title Server for the Shiny App
#' @description Server logic for the Ice Cream Party Simulation app.
#' @author Sofia Daza
#' @import shiny
#' @export
server <- function(input, output, session) {
  observeEvent(input$simulate, {
    cities <- c(input$city1, input$city2, input$city3)
    simulation_counts <- c(input$simulations1, input$simulations2, input$simulations3)

    combined_data_list <- lapply(cities, function(city) {
      weather_data <- lookup_weather_data(city)
      if (!is.null(weather_data)) {
        data.frame(
          date = as.POSIXct(weather_data$list$dt, origin = "1970-01-01", tz = "UTC"),
          temp = weather_data$list$main.temp,
          humidity = weather_data$list$main.humidity / 100,
          pressure = weather_data$list$main.pressure,
          city = weather_data$city$name
        )
      } else {
        NULL
      }
    })

    for (i in seq_along(cities)) {
      city <- cities[i]
      combined_data <- combined_data_list[[i]]

      if (!is.null(combined_data)) {
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

        output[[paste0("simulationSummary", i)]] <- renderPrint({
          cat("Results for", city, "\n")
          cat("Mean Volume (cm³):", round(results$mean_volume, 2), "\n")
          cat("SD Volume (cm³):", round(results$sd_volume, 2), "\n")
          cat("99th Percentile Volume (cm³):", round(results$volume_99, 2), "\n")
          cat("Mean Surface Area (cm²):", round(results$mean_surface_area, 2), "\n")
          cat("SD Surface Area (cm²):", round(results$sd_surface_area, 2), "\n")
          cat("99th Percentile Surface Area (cm²):", round(results$surface_area_99, 2), "\n")
        })
      } else {
        showNotification(paste("Weather data could not be retrieved for", city), type = "error")
      }
    }
  })
}
