library(testthat)
library(tidyverse)

source("scripts/functions/continents_function.R")

test_that("Longitude over 180", {
  expect_error(continents1(187,15))
})

test_that("Longitude les than -180", {
  expect_error(continents1(-182,15))
})

test_that("Longitude over-180", {
  expect_error(continents1(-180,15))
})
