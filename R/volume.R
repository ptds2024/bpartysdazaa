#' @title Volume Calculations
#' @description Functions to calculate the volume and surface area of a cone.
#' @return The calculated volume or surface area.
#' @examples volume()
#' @author Sofia Daza
#' @importFrom stats integrate
#' @export
volume <- function() {
  volume_int <- integrate(function(x) pi * cone_radius_ifelse(x)^2, 0, 10)$value
  return(volume_int)
}

