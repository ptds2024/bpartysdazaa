test_that("lookup_weather_data works", {
  expect_error(lookup_weather_data("InvalidCity"), "Failed to retrieve weather data for")
})
