library(testthat)
library(tidyverse)

source("functions/show_continent_function.R")

test_that("Longitude over 180 throws error", {
  expect_error(show_continent(187, 15))
})

test_that("Longitude les than -180 throws error", {
  expect_error(show_continent(-182, 15))
})

test_that("Latitude over 90 throws error", {
  expect_error(show_continent(-135, 91))
})

test_that("Latitude less than - 90 throws error", {
  expect_error(show_continent(-135, -91))
})

test_that("39.80000, 16.20000 shows Europe", {
  expect_equal(show_continent(39.80000, 16.20000), "Europe")
})
