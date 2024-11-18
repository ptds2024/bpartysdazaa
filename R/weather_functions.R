#' @title Lookup Weather Data
#' @description Retrieves weather forecast data for a given city from the OpenWeatherMap API.
#' @param city A string representing the name of the city.
#' @return A list containing the weather data or `NULL` if the request fails.
#' @author Sofia Daza
#' @export
lookup_weather_data <- function(city) {
  if (!is.character(city)) {
    stop("city must be a string")
  }

  tryCatch({
    forecast_response <- httr::GET(
      "http://api.openweathermap.org/data/2.5/forecast",
      query = list(q = city, appid = api_key, units = "metric")
    )

    if (httr::status_code(forecast_response) == 200) {
      forecast <- jsonlite::fromJSON(httr::content(forecast_response, "text"), flatten = TRUE)
      return(list(
        cod = forecast$cod,
        list = forecast$list,
        city = forecast$city
      ))
    } else {
      stop(paste("Failed to retrieve weather data for", city, "- Status code:", httr::status_code(forecast_response)))
    }
  }, error = function(e) {
    stop(paste("Error: ", e$message))
  })
}

