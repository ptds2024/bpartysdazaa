library(shinytest2)

test_that("run_app launches without errors", {
  app_dir <- system.file("shinyapp", package = "bpartysdazaa")
  app <- AppDriver$new(app_dir, name = "run_app_test", height = 800, width = 1200)
  expect_true(!is.null(app))
  app$stop()
})
