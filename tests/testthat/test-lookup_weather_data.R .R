Sys.setenv(OWM_API_KEY = "2182f079891d9fd66a8d807af24382bf")
api_key <- Sys.getenv("OWM_API_KEY")

test_that("lookup_weather_data works", {
  expect_error(lookup_weather_data("InvalidCity"), "Failed to retrieve weather data for")
})
