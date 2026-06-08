root <- normalizePath(file.path("raw-selected-datasets"), mustWork = TRUE)

entry <- function(name, file, title, task, target, reference,
                  time = NA_character_, event = NA_character_,
                  notes = NA_character_, header = TRUE,
                  col_names = NULL) {
  list(
    name = name,
    file = file.path(root, file),
    title = title,
    task = task,
    target = target,
    time = time,
    event = event,
    reference = reference,
    notes = notes,
    header = header,
    col_names = col_names
  )
}

entries <- list(
  entry(
    "arthritis", "arthritis.csv", "Arthritis and cardiovascular risk factors",
    "classification", "status",
    "Local curated extract; original reference not yet identified.",
    notes = "Status outcome with demographic and clinical covariates."
  ),
  entry(
    "breast", "breast.csv", "Breast cancer survival data",
    "survival", "status", "time", "status",
    "Schumacher et al. (1994), German Breast Cancer Study Group; distributed in survival modelling examples.",
    notes = "Time-to-event breast cancer endpoint with hormone and tumour covariates."
  ),
  entry(
    "colon_cancer", "colon.csv", "Colon cancer recurrence and death data",
    "survival", "status", "time", "status",
    "Moertel et al. (1990), levamisole and fluorouracil adjuvant therapy trial; distributed with the R survival package.",
    notes = "Colon cancer clinical trial survival benchmark."
  ),
  entry(
    "crc_mondaca2020", "crc_df_Mondaca,2020.csv", "Colorectal cancer genomic cohort",
    "survival", "status", "time", "status",
    "Mondaca et al. (2020), colorectal cancer cohort manuscript included with the raw-selected-datasets sources.",
    notes = "Clinical and genomic variables with survival status."
  ),
  entry(
    "crc_fes", "crc_fes/CRC.csv", "Colorectal cancer cohort from Fez",
    "survival", "event", "time", "event",
    "Scientific Reports article 51304 (2024), PDF included with the raw-selected-datasets sources.",
    notes = "Clinical colorectal cancer variables including delay and survival outcome."
  ),
  entry(
    "maternal_bangladesh", "data_bangladesh/Dataset - Updated.csv", "Maternal health risk assessment in Bangladesh",
    "classification", "Risk Level",
    "Data in Brief article S2352340925000952 (2025), PDF included with the raw-selected-datasets sources.",
    notes = "Maternal health measurements with categorical risk level."
  ),
  entry(
    "diabetes_prediction", "diabetes_prediction_dataset.csv/diabetes_prediction_dataset.csv",
    "Diabetes prediction records", "classification", "diabetes",
    "Local curated extract; original reference not yet identified.",
    notes = "Binary diabetes endpoint with demographic and laboratory variables."
  ),
  entry(
    "framingham", "framingham.csv", "Framingham heart study survival extract",
    "survival", "status", "time", "status",
    "Dawber (1980), The Framingham Study; common survival-analysis benchmark extract.",
    notes = "Cardiovascular follow-up variables with event time and cause fields."
  ),
  entry(
    "haberman", "haberman/haberman.csv", "Haberman breast cancer survival dataset",
    "classification", "survival_status",
    "Haberman (1976), UCI Machine Learning Repository, Survival of patients who had undergone surgery for breast cancer.",
    notes = "Three predictors and a two-level survival-status outcome.",
    header = FALSE,
    col_names = c("age", "operation_year", "positive_axillary_nodes", "survival_status")
  ),
  entry(
    "heart_failure", "heart_failure_clinical_records_dataset.csv",
    "Heart failure clinical records", "survival", "DEATH_EVENT", "time", "DEATH_EVENT",
    "Chicco and Jurman (2020), BMC Medical Informatics and Decision Making, heart failure clinical records dataset.",
    notes = "Clinical heart failure variables with follow-up time and death event."
  ),
  entry(
    "high_risk_pregnancy", "high_risk_pregnancy/Dataset - Updated.csv",
    "High-risk pregnancy assessment", "classification", "Risk Level",
    "Mendeley Data maternal health risk assessment dataset; PDF included with the raw-selected-datasets sources.",
    notes = "Maternal measurements with categorical risk level."
  ),
  entry(
    "kickstarter", "kickstarter.csv", "Kickstarter campaign outcomes",
    "regression", "pledged",
    "Local curated extract; original reference not yet identified.",
    notes = "Crowdfunding campaign features for pledged amount benchmarking."
  ),
  entry(
    "metabric", "metabric/metabric.csv", "METABRIC breast cancer cohort",
    "survival", "overall_survival", "overall_survival_months", "overall_survival",
    "Curtis et al. (2012), Nature; Pereira et al. (2016), Nature Communications METABRIC molecular taxonomy resources.",
    notes = "Breast cancer clinical, expression, mutation, and survival variables."
  ),
  entry(
    "pbc", "pbc.csv", "Primary biliary cholangitis trial data",
    "survival", "status", "time", "status",
    "Fleming and Harrington (1991), Counting Processes and Survival Analysis; distributed with the R survival package.",
    notes = "Mayo Clinic primary biliary cholangitis trial survival data."
  ),
  entry(
    "pima_diabetes", "pima_diabetes/pima_diabetes.csv", "Pima Indians diabetes data",
    "classification", "diabetes",
    "Smith et al. (1988), National Institute of Diabetes and Digestive and Kidney Diseases; UCI Machine Learning Repository.",
    notes = "Binary diabetes endpoint with clinical predictors."
  ),
  entry(
    "tobacco_morocco", "tobacco/cigsmoke.csv", "Morocco youth tobacco survey extract",
    "classification", "cigar_use",
    "Global Youth Tobacco Survey Morocco materials and tobacco-use manuscripts included with the raw-selected-datasets sources.",
    notes = "Youth tobacco survey variables with smoking and exposure indicators."
  ),
  entry(
    "crc_fes_delay", "crc_fes/CRC.csv", "Colorectal cancer diagnosis delay from Fez",
    "regression", "Delay",
    "Scientific Reports article 51304 (2024), PDF included with the raw-selected-datasets sources.",
    notes = "Regression task for diagnosis or treatment delay."
  ),
  entry(
    "tobacco_age_first_cigarette", "tobacco/cigsmoke.csv", "Age at first cigarette in Morocco youth survey",
    "regression", "age_first_cig",
    "Global Youth Tobacco Survey Morocco materials and tobacco-use manuscripts included with the raw-selected-datasets sources.",
    notes = "Regression task for age at first cigarette among survey respondents."
  )
)

read_entry <- function(x) {
  data <- read.csv(
    x$file,
    header = x$header,
    check.names = FALSE,
    stringsAsFactors = FALSE
  )
  if (!is.null(x$col_names)) {
    names(data) <- x$col_names
  }
  data
}

dir.create("data", showWarnings = FALSE)
dir.create("man", showWarnings = FALSE)

registry <- data.frame(
  name = vapply(entries, `[[`, character(1), "name"),
  title = vapply(entries, `[[`, character(1), "title"),
  task = vapply(entries, `[[`, character(1), "task"),
  target = vapply(entries, `[[`, character(1), "target"),
  time = vapply(entries, `[[`, character(1), "time"),
  event = vapply(entries, `[[`, character(1), "event"),
  source_path = vapply(entries, function(x) sub(paste0("^", root, "/?"), "raw-selected-datasets/", x$file), character(1)),
  reference = vapply(entries, `[[`, character(1), "reference"),
  notes = vapply(entries, `[[`, character(1), "notes"),
  stringsAsFactors = FALSE
)

unique_data_files <- entries[!duplicated(vapply(entries, `[[`, character(1), "name"))]
objects <- character()

for (x in unique_data_files) {
  data <- read_entry(x)
  registry$n_rows[registry$name == x$name] <- nrow(data)
  registry$n_columns[registry$name == x$name] <- ncol(data)
  assign(x$name, data)
  save(list = x$name, file = file.path("data", paste0(x$name, ".rda")), compress = "xz")
  objects <- c(objects, x$name)
}

biostatlab_registry <- registry
save(biostatlab_registry, file = file.path("data", "biostatlab_registry.rda"), compress = "xz")

escape_rd <- function(x) {
  x <- gsub("\\\\", "\\\\\\\\", x)
  x <- gsub("%", "\\\\%", x)
  x
}

for (x in entries) {
  rd <- c(
    paste0("\\name{", x$name, "}"),
    paste0("\\alias{", x$name, "}"),
    paste0("\\docType{data}"),
    paste0("\\title{", escape_rd(x$title), "}"),
    "\\description{",
    paste0(escape_rd(x$notes), " Task type: ", x$task, "."),
    "}",
    "\\usage{",
    paste0("data(", x$name, ")"),
    "}",
    "\\format{",
    paste0("A data frame with ", registry$n_rows[registry$name == x$name][1], " rows and ",
           registry$n_columns[registry$name == x$name][1], " columns."),
    "}",
    "\\details{",
    paste0("Target column: \\code{", escape_rd(x$target), "}."),
    if (!is.na(x$time)) paste0(" Time column: \\code{", escape_rd(x$time), "}.") else "",
    if (!is.na(x$event)) paste0(" Event column: \\code{", escape_rd(x$event), "}.") else "",
    "}",
    "\\source{",
    paste0("\\code{", escape_rd(registry$source_path[registry$name == x$name][1]), "}. ",
           escape_rd(x$reference)),
    "}",
    "\\keyword{datasets}"
  )
  writeLines(rd, file.path("man", paste0(x$name, ".Rd")))
}

writeLines(c(
  "\\name{biostatlab_registry}",
  "\\alias{biostatlab_registry}",
  "\\docType{data}",
  "\\title{biostatlab Dataset Registry}",
  "\\description{Registry of packaged datasets and benchmark task metadata.}",
  "\\usage{data(biostatlab_registry)}",
  "\\format{A data frame with one row per benchmark task entry.}",
  "\\keyword{datasets}"
), file.path("man", "biostatlab_registry.Rd"))
