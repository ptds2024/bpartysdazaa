#' @title Cone Radius Non-Vectorized Function
#' @description Calculates the radius of the cone based on the input height.
#' @param x A numeric value representing the height.
#' @return A numeric value representing the radius of the cone.
#' @examples
#' cone_radius(5)
#' cone_radius(-1)
#' @author Sofia Daza
#' @export
cone_radius <- function(x) {
  if (x < 0) {
    return(0)
  } else if (x < 8) {
    return(x / 8)
  } else if (x < 8 + pi / 2) {
    return(1 + 1.5 * sin(x - 8))
  } else if (x < 10) {
    return(2.5 - 2 * cos(x - 8))
  } else {
    return(0)
  }
}

