
# biostatlab

`biostatlab` is an R data package for biostatistics labs and modelling
benchmarks. It stores curated datasets as package data and exposes a
registry that groups tasks into survival, classification, and regression
workflows.

## Usage

``` r
library(biostatlab)

dataset_registry()
datasets_by_task("survival")
heart_failure <- load_dataset("heart_failure")
```

Each dataset has a documentation page with dimensions, task type, target
columns, and references when available.

## Available Datasets

| Dataset                       | Task           | Outcome                                           | Predictors  | Source                                                                                                                     | Title                                          |
|:------------------------------|:---------------|:--------------------------------------------------|:------------|:---------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------|
| `arthritis`                   | classification | `status`                                          | 11 columns  | Local curated extract; original reference not yet identified.                                                              | Arthritis and cardiovascular risk factors      |
| `breast`                      | survival       | `Surv(time, status)`                              | 8 columns   | Schumacher et al. (1994), German Breast Cancer Study Group; distributed in survival modelling examples.                    | Breast cancer survival data                    |
| `colon_cancer`                | survival       | `Surv(time, status)`                              | 13 columns  | Moertel et al. (1990), levamisole and fluorouracil adjuvant therapy trial; distributed with the R survival package.        | Colon cancer recurrence and death data         |
| `crc_mondaca2020`             | survival       | `Surv(time, status)`                              | 17 columns  | Mondaca et al. (2020), colorectal cancer cohort manuscript included with the raw-selected-datasets sources.                | Colorectal cancer genomic cohort               |
| `crc_fes`                     | survival       | `Surv(time, event)`                               | 17 columns  | Scientific Reports article 51304 (2024), PDF included with the raw-selected-datasets sources.                              | Colorectal cancer cohort from Fez              |
| `maternal_bangladesh`         | classification | `Risk Level`                                      | 11 columns  | Data in Brief article S2352340925000952 (2025), PDF included with the raw-selected-datasets sources.                       | Maternal health risk assessment in Bangladesh  |
| `diabetes_prediction`         | classification | `diabetes`                                        | 8 columns   | Local curated extract; original reference not yet identified.                                                              | Diabetes prediction records                    |
| `framingham`                  | survival       | `Surv(time, status)`                              | 16 columns  | Dawber (1980), The Framingham Study; common survival-analysis benchmark extract.                                           | Framingham heart study survival extract        |
| `haberman`                    | classification | `survival_status`                                 | 3 columns   | Haberman (1976), UCI Machine Learning Repository, Survival of patients who had undergone surgery for breast cancer.        | Haberman breast cancer survival dataset        |
| `heart_failure`               | survival       | `Surv(time, DEATH_EVENT)`                         | 11 columns  | Chicco and Jurman (2020), BMC Medical Informatics and Decision Making, heart failure clinical records dataset.             | Heart failure clinical records                 |
| `high_risk_pregnancy`         | classification | `Risk Level`                                      | 12 columns  | Mendeley Data maternal health risk assessment dataset; PDF included with the raw-selected-datasets sources.                | High-risk pregnancy assessment                 |
| `kickstarter`                 | regression     | `pledged`                                         | 55 columns  | Local curated extract; original reference not yet identified.                                                              | Kickstarter campaign outcomes                  |
| `metabric`                    | survival       | `Surv(overall_survival_months, overall_survival)` | 691 columns | Curtis et al. (2012), Nature; Pereira et al. (2016), Nature Communications METABRIC molecular taxonomy resources.          | METABRIC breast cancer cohort                  |
| `pbc`                         | survival       | `Surv(time, status)`                              | 17 columns  | Fleming and Harrington (1991), Counting Processes and Survival Analysis; distributed with the R survival package.          | Primary biliary cholangitis trial data         |
| `pima_diabetes`               | classification | `diabetes`                                        | 8 columns   | Smith et al. (1988), National Institute of Diabetes and Digestive and Kidney Diseases; UCI Machine Learning Repository.    | Pima Indians diabetes data                     |
| `tobacco_morocco`             | classification | `cigar_use`                                       | 26 columns  | Global Youth Tobacco Survey Morocco materials and tobacco-use manuscripts included with the raw-selected-datasets sources. | Morocco youth tobacco survey extract           |
| `crc_fes_delay`               | regression     | `Delay`                                           | 18 columns  | Scientific Reports article 51304 (2024), PDF included with the raw-selected-datasets sources.                              | Colorectal cancer diagnosis delay from Fez     |
| `tobacco_age_first_cigarette` | regression     | `age_first_cig`                                   | 26 columns  | Global Youth Tobacco Survey Morocco materials and tobacco-use manuscripts included with the raw-selected-datasets sources. | Age at first cigarette in Morocco youth survey |
