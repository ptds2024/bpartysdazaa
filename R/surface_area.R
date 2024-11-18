#' @title Surface Area of the Cone
#' @description Calculates the surface area of the cone using numerical integration.
#' @return A numeric value representing the surface area of the cone.
#' @examples
#' surface_area()
#' @importFrom stats integrate
#' @export
surface_area <- function() {
  surface_int <- integrate(function(x) {
    radius <- cone_radius_ifelse(x)
    dhdx <- derivative(x)
    2 * pi * radius * sqrt(1 + dhdx^2)
  }, 0, 10)$value
  return(surface_int)
}
