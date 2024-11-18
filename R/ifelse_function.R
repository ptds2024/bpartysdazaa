#' @title Cone Radius Function ifelse
#' @description Functions for calculating the radius of the cone using different approaches.
#' @param x_values Numeric vector of heights.
#' @return A numeric vector of radii.
#' @examples cone_radius_for(seq(0, 10, length.out = 100))
#' @author Sofia Daza
#' #' @export
cone_radius_ifelse <- function(x_values) {
  result <- ifelse(
    x_values < 0, 0,
    ifelse(
      x_values < 8, x_values / 8,
      ifelse(
        x_values < (8 + pi / 2), 1 + 1.5 * sin(x_values - 8),
        ifelse(x_values < 10, 2.5 - 2 * cos(x_values - 8), 0)
      )
    )
  )
  return(result)
}
