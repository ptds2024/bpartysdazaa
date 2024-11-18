#' @title Run Shiny App
#' @description Launches the Ice Cream Party Simulation Shiny app.
#' @author Sofia Daza
#' @import shiny
#' @export
run_app <- function() {
  shinyApp(ui = ui, server = server)
}
