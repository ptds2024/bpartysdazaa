library(shinytest2)

test_that("run_app launches without errors", {
  app <- shinytest2::AppDriver$new(system.file("shinyapp", package = "bpartysdazaa"))
  expect_silent(app$stop())
})
