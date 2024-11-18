#' @title Cone Radius Vectorized Function
#' @description Vectorized version of the `cone_radius` function for handling numeric vectors.
#' @param x Numeric vector of heights.
#' @return A numeric vector of radii.
#' @examples
#' cone_radius_vectorize(seq(0, 10, length.out = 5))
#' cone_radius_vectorize(c(-1, 0, 5, 8, 10))
#' @author Sofia Daza
#' @export
cone_radius_vectorize <- Vectorize(cone_radius)
