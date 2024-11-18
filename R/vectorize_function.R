#' @title Cone Radius Function Vectorize
#' @description Functions for calculating the radius of the cone using different approaches.
#' @param x_values Numeric vector of heights.
#' @return A numeric vector of radii.
#' @examples cone_radius_for(seq(0, 10, length.out = 100))
#' @author Sofia Daza
#' @export
cone_radius_vectorize <- Vectorize(cone_radius)
