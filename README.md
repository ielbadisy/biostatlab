
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

| Dataset                       | Task           | Target             | Title                                          |
|:------------------------------|:---------------|:-------------------|:-----------------------------------------------|
| `arthritis`                   | classification | `status`           | Arthritis and cardiovascular risk factors      |
| `breast`                      | survival       | `status`           | Breast cancer survival data                    |
| `colon_cancer`                | survival       | `status`           | Colon cancer recurrence and death data         |
| `crc_mondaca2020`             | survival       | `status`           | Colorectal cancer genomic cohort               |
| `crc_fes`                     | survival       | `event`            | Colorectal cancer cohort from Fez              |
| `maternal_bangladesh`         | classification | `Risk Level`       | Maternal health risk assessment in Bangladesh  |
| `diabetes_prediction`         | classification | `diabetes`         | Diabetes prediction records                    |
| `framingham`                  | survival       | `status`           | Framingham heart study survival extract        |
| `haberman`                    | classification | `survival_status`  | Haberman breast cancer survival dataset        |
| `heart_failure`               | survival       | `DEATH_EVENT`      | Heart failure clinical records                 |
| `high_risk_pregnancy`         | classification | `Risk Level`       | High-risk pregnancy assessment                 |
| `kickstarter`                 | regression     | `pledged`          | Kickstarter campaign outcomes                  |
| `metabric`                    | survival       | `overall_survival` | METABRIC breast cancer cohort                  |
| `pbc`                         | survival       | `status`           | Primary biliary cholangitis trial data         |
| `pima_diabetes`               | classification | `diabetes`         | Pima Indians diabetes data                     |
| `tobacco_morocco`             | classification | `cigar_use`        | Morocco youth tobacco survey extract           |
| `crc_fes_delay`               | regression     | `Delay`            | Colorectal cancer diagnosis delay from Fez     |
| `tobacco_age_first_cigarette` | regression     | `age_first_cig`    | Age at first cigarette in Morocco youth survey |
