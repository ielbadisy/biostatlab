test_that("registry exposes packaged datasets", {
  reg <- dataset_registry()

  expect_s3_class(reg, "data.frame")
  expect_true(all(c("name", "task", "target") %in% names(reg)))
  expect_true(all(c("survival", "classification", "regression") %in% reg$task))
  expect_setequal(available_datasets(), reg$name)
})

test_that("task filtering and loading work", {
  survival_sets <- datasets_by_task("survival")

  expect_gt(nrow(survival_sets), 0)
  expect_error(datasets_by_task("clustering"), "must be one of")
  expect_s3_class(load_dataset("heart_failure"), "data.frame")
  expect_error(load_dataset("missing_dataset"), "Unknown dataset")
})
