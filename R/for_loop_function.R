#' @title Cone Radius Function using for loop
#' @description Functions for calculating the radius of the cone using different approaches.
#' @param x_values Numeric vector of heights.
#' @return A numeric vector of radii.
#' @examples cone_radius_for(seq(0, 10, length.out = 100))
#' @author Sofia Daza
#' @export
cone_radius_for <- function(x_values) {
  rad <- numeric(length(x_values))
  for (i in seq_along(x_values)) {
    rad[i] <- cone_radius(x_values[i])
  }
  return(rad)
}
