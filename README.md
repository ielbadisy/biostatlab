# biostatlabdata

`biostatlabdata` is an R data package for biostatistics labs and modelling
benchmarks. It stores curated datasets as package data and exposes a registry
that groups tasks into survival, classification, and regression workflows.

## Usage

```r
library(biostatlabdata)

dataset_registry()
datasets_by_task("survival")
heart_failure <- load_dataset("heart_failure")
```

Each dataset has a documentation page with dimensions, task type, target
columns, and references when available.
