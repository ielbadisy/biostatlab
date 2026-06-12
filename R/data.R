#' Dataset registry
#'
#' Metadata for all datasets included in the package. Columns include dataset
#' name, title, task type, target columns, source path, reference, number of
#' rows, and number of columns.
#'
#' @format A data frame with one row per packaged dataset.
"biostatlab_registry"

utils::globalVariables("biostatlab_registry")

#' Diastolic Blood Pressure Trial
#'
#' A reconstructed hypertension clinical trial dataset with treatment assignment,
#' baseline diastolic blood pressure, monthly follow-up measurements through four
#' months, age, and sex.
#'
#' @format A data frame with 40 rows and 9 variables:
#' \describe{
#'   \item{Subject}{Participant identifier.}
#'   \item{TRT}{Randomized treatment group: new drug `A` or placebo `B`.}
#'   \item{DBP1}{Baseline supine diastolic blood pressure in mm Hg.}
#'   \item{DBP2}{Month 1 supine diastolic blood pressure in mm Hg.}
#'   \item{DBP3}{Month 2 supine diastolic blood pressure in mm Hg.}
#'   \item{DBP4}{Month 3 supine diastolic blood pressure in mm Hg.}
#'   \item{DBP5}{Month 4 supine diastolic blood pressure in mm Hg.}
#'   \item{Age}{Baseline age.}
#'   \item{Sex}{Recorded sex.}
#' }
#' @source Peace and Chen (2010), *Clinical Trial Data Analysis Using R*, Table
#'   3.1. The package data object was reconstructed from local development
#'   source files retained outside the remote package source.
"dpb"

#' Duodenal Ulcer Healing Trial
#'
#' A reconstructed subject-level cimetidine dose comparison trial for duodenal
#' ulcer healing, with treatment group, dose, healing indicators at weeks 1, 2,
#' and 4, and derived healing time.
#'
#' @format A data frame with 703 rows and 7 variables:
#' \describe{
#'   \item{Subject}{Participant identifier.}
#'   \item{TRT}{Treatment group.}
#'   \item{Dose_mg}{Cimetidine dose in milligrams.}
#'   \item{Healed_Week1}{Indicator for healing by week 1.}
#'   \item{Healed_Week2}{Indicator for healing by week 2.}
#'   \item{Healed_Week4}{Indicator for healing by week 4.}
#'   \item{Healing_Time}{First observed healing time category.}
#' }
#' @source Peace and Chen (2010), *Clinical Trial Data Analysis Using R*, Table
#'   3.2. The package data object was reconstructed from local development
#'   source files retained outside the remote package source.
"duodenal"

#' Streptomycin Tuberculosis Trial
#'
#' Randomized placebo-controlled trial of streptomycin therapy for pulmonary
#' tuberculosis, including treatment arm, baseline clinical findings, six-month
#' radiologic response, and a binary improvement outcome.
#'
#' @format A data frame with 107 rows and 13 variables, including treatment arm,
#'   streptomycin dose, sex, baseline clinical status, baseline cavitation,
#'   streptomycin resistance, radiologic response at six months, and
#'   `improved`.
#' @source Streptomycin in Tuberculosis Trials Committee (1948), *British
#'   Medical Journal*. Repackaged from `medicaldata::strep_tb`.
"streptb"

#' Respiratory Illness Trial
#'
#' Long-form repeated-measures data from a randomized multicenter respiratory
#' illness trial comparing active treatment with placebo.
#'
#' @format A data frame with 555 rows and 7 variables:
#' \describe{
#'   \item{centre}{Study center.}
#'   \item{treatment}{Treatment arm.}
#'   \item{gender}{Patient gender.}
#'   \item{age}{Patient age.}
#'   \item{status}{Respiratory status, the response variable.}
#'   \item{month}{Visit month.}
#'   \item{subject}{Patient identifier.}
#' }
#' @source Davis, C. S. (1991), "Semi-parametric and non-parametric methods for
#'   the analysis of repeated measurements with applications to clinical
#'   trials", *Statistics in Medicine*, 10, 1959-1980. Repackaged from
#'   `HSAUR3::respiratory`.
"respiratory"

#' Epilepsy Progabide Trial
#'
#' Longitudinal randomized clinical trial data for the anti-epileptic drug
#' Progabide, with seizure counts recorded across four treatment periods.
#'
#' @format A data frame with 236 rows and 6 variables:
#' \describe{
#'   \item{treatment}{Treatment group.}
#'   \item{base}{Baseline seizure count before the trial.}
#'   \item{age}{Patient age.}
#'   \item{seizure.rate}{Number of seizures in the treatment period.}
#'   \item{period}{Treatment period.}
#'   \item{subject}{Patient identifier.}
#' }
#' @source Thall, P. F. and Vail, S. C. (1990), "Some covariance models for
#'   longitudinal count data with overdispersion", *Biometrics*, 46, 657-671.
#'   Repackaged from `HSAUR2::epilepsy`.
"epilepsy"

#' Simulated Cardiovascular Teaching Dataset
#'
#' A simulated clinical dataset for teaching cardiovascular data analysis. The
#' records include demographic variables, treatment assignment, smoking and
#' diabetes indicators, repeated systolic blood pressure measurements,
#' biomarkers, adherence, and derived blood-pressure control outcomes.
#'
#' This dataset is simulated for teaching purposes. It should not be interpreted
#' as real patient data or used for clinical inference.
#'
#' @format A data frame with 180 rows and 17 variables:
#' \describe{
#'   \item{id}{Simulated participant identifier.}
#'   \item{sex}{Simulated sex.}
#'   \item{treatment}{Simulated treatment group: `Control`, `DrugA`, or `DrugB`.}
#'   \item{smoker}{Simulated smoking indicator.}
#'   \item{diabetes}{Simulated diabetes indicator.}
#'   \item{age}{Simulated age in years.}
#'   \item{sbp_baseline}{Simulated baseline systolic blood pressure.}
#'   \item{treatment_effect}{Simulated treatment effect applied to follow-up SBP.}
#'   \item{sbp_3m}{Simulated systolic blood pressure at 3 months.}
#'   \item{sbp_6m}{Simulated systolic blood pressure at 6 months.}
#'   \item{ldl}{Simulated LDL cholesterol.}
#'   \item{crp}{Simulated C-reactive protein.}
#'   \item{adherence}{Simulated adherence category.}
#'   \item{response}{Derived 3-month control response.}
#'   \item{controlled_baseline}{Derived baseline control status.}
#'   \item{controlled_3m}{Derived 3-month control status.}
#'   \item{controlled_6m}{Derived 6-month control status.}
#' }
#' @source Simulated by the biostatlab package for teaching purposes; generated
#'   in `data-raw/prepare_datasets.R` with seed 20260612.
"cardio"
