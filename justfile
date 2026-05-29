default:
    @just --list -u

build:
  Rscript --vanilla build/build-dataset.R
