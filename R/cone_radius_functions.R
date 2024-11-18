#' @title Cone Radius Non Vectorized Function
#' @description Functions for calculating the radius of the cone using different approaches.
#' @param x_values height
#' @return A radius
#' @examples 2
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
