#' @title Simulate Party (Simple)
#' @description Simulates ice cream consumption based on weather data.
#' @param num_simulations Number of simulations to perform.
#' @param combined_data A data frame with weather data (temperature, humidity, pressure).
#' @param volume_base Base volume per cone in cm³ (default: 39.88).
#' @param surface_base Base surface area per cone in cm² (default: 52.71).
#' @param variation_percent Percentage variation for volume and surface area (default: 10).
#' @return A list of simulation results, including total and mean volumes and surface areas.
#' @author Sofia Daza
#' @importFrom stats quantile rpois runif sd
#' @export
simulate_party_simple <- function(num_simulations, combined_data, volume_base = 39.88, surface_base = 52.71, variation_percent = 10) {
  if (num_simulations <= 0) stop("num_simulations must be positive")
  if (nrow(combined_data) == 0) stop("combined_data cannot be empty")

  total_volumes <- numeric(num_simulations)
  total_surface_areas <- numeric(num_simulations)

  volume_variation <- calculate_variations(volume_base, variation_percent)
  surface_area_variation <- calculate_variations(surface_base, variation_percent)

  for (sim in 1:num_simulations) {
    forecast_sample <- combined_data[sample(nrow(combined_data), 1), ]
    lambda <- exp(0.5 + 0.5 * forecast_sample$temp - 3 * forecast_sample$humidity + 0.001 * forecast_sample$pressure)
    guests <- rpois(1, lambda)
    total_cones <- sum(sample(c(1, 2), guests, replace = TRUE, prob = c(0.67, 0.33)))

    volume_per_cone <- runif(total_cones, volume_variation$lower, volume_variation$upper)
    surface_area_per_cone <- runif(total_cones, surface_area_variation$lower, surface_area_variation$upper)

    total_volumes[sim] <- sum(volume_per_cone)
    total_surface_areas[sim] <- sum(surface_area_per_cone)
  }

  return(list(
    mean_volume = mean(total_volumes),
    sd_volume = sd(total_volumes),
    volume_99 = quantile(total_volumes, 0.99),
    mean_surface_area = mean(total_surface_areas),
    sd_surface_area = sd(total_surface_areas),
    surface_area_99 = quantile(total_surface_areas, 0.99),
    total_volume = total_volumes,
    total_surface_area = total_surface_areas
  ))
}

