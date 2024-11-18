library(shinytest2)

test_that("run_app launches without errors", {
  app <- AppDriver$new(test_path("inst/shinyapp/"), name = "run_app_test", height = 800, width = 1200)
  expect_true(!is.null(app))
  app$stop()
})
