library(testthat)

test_that("lookup_weather_data works", {
  httptest2::with_mock_api({
    mock_valid <- list(
      cod = "200",
      list = data.frame(temp = c(10, 12, 15), humidity = c(0.8, 0.7)),
      city = list(name = "Lausanne")
    )
    httptest2::capture_requests({
      expect_named(lookup_weather_data("Lausanne"), c("cod", "list", "city"))
    })

    httptest2::capture_requests({
      expect_error(lookup_weather_data("InvalidCity"), "Failed to retrieve weather data for")
    })
  })
})
