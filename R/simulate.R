#' @title Party Simulation
#' @description Functions to simulate party resources based on weather forecasts.
#' @param num_guests Number of guests attending the party.
#' @return Simulated total cones and guest information.
#' @author Sofia Daza
#' @export
simulation <- function(num_guests) {
  rbinom(num_guests, size = 1, prob = 0.33) + 1
}
