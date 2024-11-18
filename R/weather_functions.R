#' @title Weather Data Retrieval
#' @description Functions to retrieve and process weather data using the OpenWeather API.
#' @param city A character string for the city name.
#' @return A list containing current and forecast weather data.
#' @examples lookup_weather_data("Lausanne")
#' @author Sofia Daza
lookup_weather_data <- function(city) {
  tryCatch({
    forecast_response <- httr::GET(
      "http://api.openweathermap.org/data/2.5/forecast",
      query = list(q = city, appid = Sys.getenv("OWM_API_KEY"), units = "metric")
    )

    if (httr::status_code(forecast_response) == 200) {
      forecast <- jsonlite::fromJSON(httr::content(forecast_response, "text"), flatten = TRUE)
      return(forecast)
    } else {
      stop("Failed to retrieve weather data")
    }
  }, error = function(e) {
    message("Error: ", e$message)
    return(NULL)
  })
}
