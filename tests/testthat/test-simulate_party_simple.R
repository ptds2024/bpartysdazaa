test_that("simulate_party_simple works", {
  combined_data <- data.frame(
    date = as.POSIXct("2024-11-19"),
    temp = 10,
    humidity = 0.5,
    pressure = 1013,
    city = "Lausanne"
  )

  results <- simulate_party_simple(100, combined_data)
  expect_true(!is.null(results))
  expect_named(results, c(
    "mean_volume", "sd_volume", "volume_99",
    "mean_surface_area", "sd_surface_area", "surface_area_99",
    "total_volume", "total_surface_area"
  ))

  expect_type(results$total_volume, "double")
  expect_type(results$total_surface_area, "double")

  expect_error(simulate_party_simple(-100, combined_data), "num_simulations must be positive")
  expect_error(simulate_party_simple(100, data.frame()), "combined_data cannot be empty")
})
