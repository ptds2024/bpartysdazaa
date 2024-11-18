test_that("run_app launches without errors", {
  expect_silent({
    shiny::testServer(run_app())
  })
})
