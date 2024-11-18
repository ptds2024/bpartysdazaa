test_that("run_app launches without errors", {
  expect_silent({
    shinytest::testServer(run_app())
  })
})
