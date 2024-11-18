#' @title Numerical Derivative of Cone Radius
#' @description Approximates the derivative of the `cone_radius_ifelse` function at a given height.
#' @param x A numeric value representing the height.
#' @param epsilon A small numeric value used for numerical differentiation. Default is 1e-5.
#' @return A numeric value representing the approximate derivative.
#' @examples
#' derivative(5)
#' derivative(8)
#' @export
derivative <- function(x, epsilon = 1e-5) {
  (cone_radius_ifelse(x + epsilon) - cone_radius_ifelse(x)) / epsilon
}
