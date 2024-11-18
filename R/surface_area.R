#' @title Surface Area Calculations
#' @description Functions to calculate the volume and surface area of a cone.
#' @return The calculated volume or surface area.
#' @examples volume()
#' @author Sofia Daza

derivative <- function(x, epsilon = 1e-5) {
  (cone_radius_ifelse(x + epsilon) - cone_radius_ifelse(x)) / epsilon
}

surface_area <- function() {
  surface_int <- integrate(function(x) {
    x <- cone_radius_ifelse(x)
    dhdx <- derivative(x)
    2 * pi * x * sqrt(1 + dhdx^2)
  }, 0, 10)$value
  return(surface_int)
}
