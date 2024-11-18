#' @title Simulation Function
#' @description Simulates some process using `rbinom`.
#' @param n Number of trials.
#' @param prob Probability of success.
#' @return A vector of simulated outcomes.
#' @examples
#' simulation(100, 0.5)
#' @importFrom stats rbinom
#' @export
simulation <- function(n, prob) {
  rbinom(n, size = 1, prob = prob)
}
