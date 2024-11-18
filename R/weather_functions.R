#' @title Weather Data Retrieval
#' @description Functions to retrieve and process weather data using the OpenWeather API.
#' @param city A character string for the city name.
#' @return A list containing current and forecast weather data.
#' @examples lookup_weather_data("Lausanne")
#' @author Sofia Daza
#' @export
lookup_weather_data <- function(city) {
  tryCatch({
    response <- httr::GET(
      "http://api.openweathermap.org/data/2.5/forecast",
      query = list(q = city, appid = Sys.getenv("OWM_API_KEY"), units = "metric")
    )

    if (httr::status_code(response) == 200) {
      forecast <- jsonlite::fromJSON(httr::content(response, "text"), flatten = TRUE)
      return(forecast)
    } else {
      stop(paste("Failed to retrieve weather data for", city, "- Status code:", httr::status_code(response)))
    }
  }, error = function(e) {
    message("Error fetching weather data for ", city, ": ", e$message)
    return(NULL)
  })
}

