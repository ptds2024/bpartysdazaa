#' @title Cone Radius Functions
#' @description Functions for calculating the radius of the cone using different approaches.
#' @param x_values Numeric vector of heights.
#' @return A numeric vector of radii.
#' @examples cone_radius_for(seq(0, 10, length.out = 100))
#' @author Sofia Daza
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

cone_radius_for <- function(x_values) {
  rad <- numeric(length(x_values))
  for (i in seq_along(x_values)) {
    rad[i] <- cone_radius(x_values[i])
  }
  return(rad)
}

cone_radius_map <- function(x_values) {
  map_dbl(x_values, cone_radius)
}

cone_radius_sapply <- function(x_values) {
  sapply(x_values, cone_radius)
}

cone_radius_vectorize <- Vectorize(cone_radius)

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
