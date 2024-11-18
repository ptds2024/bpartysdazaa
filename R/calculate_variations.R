#' @title Calculate Variations
#' @description Computes the lower and upper bounds for a given base value and variation percentage.
#' @param base_value A numeric value representing the base.
#' @param variation_percent A numeric value representing the variation percentage.
#' @return A list with `lower` and `upper` bounds.
#' @author Sofia Daza
#' @export
calculate_variations <- function(base_value, variation_percent) {
  list(
    lower = base_value * (1 - variation_percent / 100),
    upper = base_value * (1 + variation_percent / 100)
  )
}
