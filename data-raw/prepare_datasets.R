root <- normalizePath(file.path("raw-selected-datasets"), mustWork = FALSE)
clinical_root <- normalizePath(file.path("data-raw", "clinical-trial-data"), mustWork = FALSE)

entry <- function(name, file, title, task, target, reference,
                  time = NA_character_, event = NA_character_,
                  notes = NA_character_, header = TRUE,
                  col_names = NULL, reader = NULL) {
  list(
    name = name,
    file = if (is.null(reader)) file.path(root, file) else file,
    title = title,
    task = task,
    target = target,
    time = time,
    event = event,
    reference = reference,
    notes = notes,
    header = header,
    col_names = col_names,
    reader = reader
  )
}

clinical_entry <- function(name, file, title, task, target, reference,
                           notes = NA_character_) {
  entry(
    name, file, title, task, target, reference, notes = notes,
    reader = function(x) {
      clinical_file <- file.path(clinical_root, x$file)
      if (!file.exists(clinical_file)) {
        rda <- file.path("data", paste0(x$name, ".rda"))
        if (file.exists(rda)) {
          e <- new.env(parent = emptyenv())
          load(rda, envir = e)
          return(get(x$name, envir = e, inherits = FALSE))
        }
      }
      read.csv(
        clinical_file,
        check.names = FALSE,
        stringsAsFactors = FALSE
      )
    }
  )
}

package_entry <- function(name, package, object, title, task, target, reference,
                          notes = NA_character_) {
  entry(
    name, file.path("package", package, object), title, task, target, reference,
    notes = notes,
    reader = function(x) {
      e <- new.env(parent = emptyenv())
      data(list = object, package = package, envir = e)
      as.data.frame(get(object, envir = e, inherits = FALSE))
    }
  )
}

simulated_cardio <- function(seed = 20260612L, n = 180L) {
  set.seed(seed)

  cardio <- data.frame(
    id = seq_len(n),
    sex = sample(c("Female", "Male"), n, replace = TRUE),
    treatment = sample(c("Control", "DrugA", "DrugB"), n, replace = TRUE),
    smoker = sample(c("No", "Yes"), n, replace = TRUE, prob = c(0.65, 0.35)),
    diabetes = sample(c("No", "Yes"), n, replace = TRUE, prob = c(0.75, 0.25)),
    age = round(rnorm(n, mean = 55, sd = 10), 1),
    stringsAsFactors = FALSE
  )

  cardio$sbp_baseline <- round(rnorm(n, mean = 145, sd = 15), 1)
  cardio$treatment_effect <- ifelse(
    cardio$treatment == "Control", 2,
    ifelse(cardio$treatment == "DrugA", -7, -12)
  )
  cardio$sbp_3m <- round(
    cardio$sbp_baseline + cardio$treatment_effect + rnorm(n, mean = 0, sd = 10),
    1
  )
  cardio$sbp_6m <- round(cardio$sbp_3m + rnorm(n, mean = -2, sd = 8), 1)
  cardio$ldl <- round(
    rnorm(n, mean = 130, sd = 30) + ifelse(cardio$diabetes == "Yes", 12, 0),
    1
  )
  cardio$crp <- round(rlnorm(n, meanlog = 1.5, sdlog = 0.6), 2)
  cardio$adherence <- sample(
    c("Low", "Moderate", "High"),
    n,
    replace = TRUE,
    prob = c(0.25, 0.45, 0.30)
  )
  cardio$response <- ifelse(cardio$sbp_3m < 140, "Controlled", "Uncontrolled")
  cardio$controlled_baseline <- ifelse(
    cardio$sbp_baseline < 140,
    "Controlled",
    "Uncontrolled"
  )
  cardio$controlled_3m <- ifelse(cardio$sbp_3m < 140, "Controlled", "Uncontrolled")
  cardio$controlled_6m <- ifelse(cardio$sbp_6m < 140, "Controlled", "Uncontrolled")

  cardio$sex <- factor(cardio$sex)
  cardio$treatment <- factor(cardio$treatment)
  cardio$smoker <- factor(cardio$smoker)
  cardio$diabetes <- factor(cardio$diabetes)
  cardio$adherence <- factor(cardio$adherence, levels = c("Low", "Moderate", "High"))
  cardio$response <- factor(cardio$response)
  cardio$controlled_baseline <- factor(cardio$controlled_baseline)
  cardio$controlled_3m <- factor(cardio$controlled_3m)
  cardio$controlled_6m <- factor(cardio$controlled_6m)

  cardio
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
    "survival", "status",
    "Schumacher et al. (1994), German Breast Cancer Study Group; distributed in survival modelling examples.",
    time = "time", event = "status",
    notes = "Time-to-event breast cancer endpoint with hormone and tumour covariates."
  ),
  entry(
    "colon_cancer", "colon.csv", "Colon cancer recurrence and death data",
    "survival", "status",
    "Moertel et al. (1990), levamisole and fluorouracil adjuvant therapy trial; distributed with the R survival package.",
    time = "time", event = "status",
    notes = "Colon cancer clinical trial survival benchmark."
  ),
  entry(
    "crc_mondaca2020", "crc_df_Mondaca,2020.csv", "Colorectal cancer genomic cohort",
    "survival", "status",
    "Mondaca et al. (2020), colorectal cancer cohort manuscript included with the raw-selected-datasets sources.",
    time = "time", event = "status",
    notes = "Clinical and genomic variables with survival status."
  ),
  entry(
    "crc_fes", "crc_fes/CRC.csv", "Colorectal cancer cohort from Fez",
    "survival", "event",
    "Scientific Reports article 51304 (2024), PDF included with the raw-selected-datasets sources.",
    time = "time", event = "event",
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
    "survival", "status",
    "Dawber (1980), The Framingham Study; common survival-analysis benchmark extract.",
    time = "time", event = "status",
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
    "Heart failure clinical records", "survival", "DEATH_EVENT",
    "Chicco and Jurman (2020), BMC Medical Informatics and Decision Making, heart failure clinical records dataset.",
    time = "time", event = "DEATH_EVENT",
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
    "survival", "overall_survival",
    "Curtis et al. (2012), Nature; Pereira et al. (2016), Nature Communications METABRIC molecular taxonomy resources.",
    time = "overall_survival_months", event = "overall_survival",
    notes = "Breast cancer clinical, expression, mutation, and survival variables."
  ),
  entry(
    "pbc", "pbc.csv", "Primary biliary cholangitis trial data",
    "survival", "status",
    "Fleming and Harrington (1991), Counting Processes and Survival Analysis; distributed with the R survival package.",
    time = "time", event = "status",
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
  ),
  clinical_entry(
    "dpb", "diastolic_blood_pressure_trial.csv", "Diastolic blood pressure trial",
    "classification", "TRT",
    "Peace and Chen (2010), Clinical Trial Data Analysis Using R, Table 3.1; reconstructed CSV in data-raw/clinical-trial-data.",
    notes = "Small hypertension clinical trial with treatment assignment, baseline DBP, repeated monthly DBP measurements, age, and sex."
  ),
  clinical_entry(
    "duodenal", "duodenal_ulcer_trial_raw_reconstructed.csv", "Duodenal ulcer healing trial",
    "classification", "Healed_Week4",
    "Peace and Chen (2010), Clinical Trial Data Analysis Using R, Table 3.2; reconstructed CSV in data-raw/clinical-trial-data.",
    notes = "Reconstructed subject-level cimetidine dose comparison trial with ulcer healing indicators at weeks 1, 2, and 4."
  ),
  package_entry(
    "streptb", "medicaldata", "strep_tb", "Streptomycin tuberculosis trial",
    "classification", "improved",
    "Streptomycin in Tuberculosis Trials Committee (1948), British Medical Journal; redistributed as medicaldata::strep_tb.",
    notes = "Randomized streptomycin tuberculosis trial with six-month radiologic improvement outcome."
  ),
  package_entry(
    "respiratory", "HSAUR3", "respiratory", "Respiratory illness trial",
    "classification", "status",
    "Davis (1991), Statistics in Medicine 10:1959-1980; redistributed as HSAUR3::respiratory.",
    notes = "Long-form multicenter respiratory trial with repeated monthly respiratory status."
  ),
  package_entry(
    "epilepsy", "HSAUR2", "epilepsy", "Epilepsy progabide trial",
    "regression", "seizure.rate",
    "Thall and Vail (1990), Biometrics 46:657-671; redistributed as HSAUR2::epilepsy.",
    notes = "Longitudinal randomized epilepsy trial with seizure counts by treatment period."
  ),
  entry(
    "cardio", "simulated/cardio", "Simulated cardiovascular teaching dataset",
    "classification", "response",
    "Simulated by the biostatlab package for teaching purposes; generated in data-raw/prepare_datasets.R with seed 20260612.",
    notes = "Simulated cardiovascular clinical teaching dataset with blood pressure, LDL, CRP, adherence, and controlled-status outcomes.",
    reader = function(x) simulated_cardio()
  )
)

read_entry <- function(x) {
  if (!is.null(x$reader)) {
    return(x$reader(x))
  }
  if (!file.exists(x$file)) {
    rda <- file.path("data", paste0(x$name, ".rda"))
    if (file.exists(rda)) {
      e <- new.env(parent = emptyenv())
      load(rda, envir = e)
      return(get(x$name, envir = e, inherits = FALSE))
    }
  }
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
  target = mapply(
    function(task, target, time, event) {
      if (identical(task, "survival")) {
        paste(stats::na.omit(c(time, event)), collapse = ", ")
      } else {
        target
      }
    },
    vapply(entries, `[[`, character(1), "task"),
    vapply(entries, `[[`, character(1), "target"),
    vapply(entries, `[[`, character(1), "time"),
    vapply(entries, `[[`, character(1), "event"),
    USE.NAMES = FALSE
  ),
  time = vapply(entries, `[[`, character(1), "time"),
  event = vapply(entries, `[[`, character(1), "event"),
  source_path = vapply(entries, function(x) sub(paste0("^", root, "/?"), "raw-selected-datasets/", x$file), character(1)),
  reference = vapply(entries, `[[`, character(1), "reference"),
  notes = vapply(entries, `[[`, character(1), "notes"),
  stringsAsFactors = FALSE
)

registry$source_path <- ifelse(
  startsWith(vapply(entries, `[[`, character(1), "file"), "package/"),
  vapply(entries, `[[`, character(1), "file"),
  ifelse(
    file.exists(file.path(clinical_root, vapply(entries, `[[`, character(1), "file"))),
    file.path("data-raw/clinical-trial-data", vapply(entries, `[[`, character(1), "file")),
    registry$source_path
  )
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
