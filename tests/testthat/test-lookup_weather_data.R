library(testthat)
library(httptest2)

test_that("lookup_weather_data works", {
  with_mock_api({
    mock_valid <- list(
      cod = "200",
      list = data.frame(temp = c(10, 12, 15), humidity = c(0.8, 0.7, 0.9)),
      city = list(name = "Lausanne")
    )

    capture_requests({
      expect_named(lookup_weather_data("Lausanne"), c("cod", "list", "city"))
    })

    capture_requests({
      expect_error(
        lookup_weather_data("InvalidCity"),
        "Failed to retrieve weather data",
        regexp = TRUE
      )
    })
  })
})
