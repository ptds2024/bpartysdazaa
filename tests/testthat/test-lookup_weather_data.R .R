test_that("lookup_weather_data works", {
  expect_error(lookup_weather_data(123), "city must be a string")

  result <- lookup_weather_data("Lausanne")
  expect_true(!is.null(result))

  expect_named(result, c("cod", "list", "city"))

  expect_error(lookup_weather_data("InvalidCity"), "Failed to retrieve weather data")
})
