test_that("tutorial and beamer templates are present in inst", {
  tutorial_dir <- test_path("..", "..", "inst", "rmarkdown", "templates", "biostatlab_tutorial")
  beamer_dir <- test_path("..", "..", "inst", "rmarkdown", "templates", "biostatlab_beamer")

  expect_true(dir.exists(tutorial_dir))
  expect_true(file.exists(file.path(tutorial_dir, "template.yaml")))
  expect_true(file.exists(file.path(tutorial_dir, "skeleton", "skeleton.Rmd")))
  expect_true(file.exists(file.path(tutorial_dir, "skeleton", "biostatlab-tutorial.css")))

  expect_true(dir.exists(beamer_dir))
  expect_true(file.exists(file.path(beamer_dir, "template.yaml")))
  expect_true(file.exists(file.path(beamer_dir, "skeleton", "skeleton.Rmd")))
})
