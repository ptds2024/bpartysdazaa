test_that("calculate_variations works", {
  variations <- calculate_variations(100, 10)
  expect_equal(variations$lower, 90)
  expect_equal(variations$upper, 110)

  variations <- calculate_variations(100, 0)
  expect_equal(variations$lower, 100)
  expect_equal(variations$upper, 100)

  expect_error(calculate_variations(-100, 10), "base_value must be non-negative")
})
