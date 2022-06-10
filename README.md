# Employee Attrition Model

> IBM HR Analytics Employee Attrition & Performance

**Authors:** Levin Reichmuth, Jorit Studer and Taejun Moon

**Module:** Machine Learning I (June 10th, 2022)

**Supervisor:** Dr. Matteo Tanadini, Daniel Meister and Dr. Alberto Paganini

## Project Structure

```
|--analysis.pdf       # Report rendered by Bookdown
|--data\              # Data for the analysis (CSV)
  |--emp_attrition.csv 
|--latex\             # Custom Title Page in Latex
  |--preamble.tex     
  |--titlepage.tex
|--references\        # References
  |--references.bib     # BibTeX references
  |--apa.csl            # APA 7th Edition Citation Style Language
```

## Installation

The following packages are required to knitr this report using bookdown.

```r
packages <- c("bookdown", "dplyr", "ggplot2", "papeR", "kableExtra", "mgcv", "caret", "vip", "rsample", "tidyverse", "yardstick", "arm", "pROC", "nnet", "NeuralNetTools", "rsample", "multcomp", "vip", "magicfor")
package.check <- lapply(packages, FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
        install.packages(x, dependencies = TRUE)
        library(x, character.only = TRUE)
    }
})
```

## Rendering

In R-Studio click on the arrow on Knit then select "Knit to pdf_document2" or "Knit to pdf_html2".
*The following project was compiled using RStudio 2021.09.2 Build 382 and R version 4.1.2 (2022-06-10).*
