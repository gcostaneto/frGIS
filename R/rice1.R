#' Rice multi-environment dataset (MET1) with phenotypic data and geographic covariates.
#'
#' A data set of upland rice genotypes containing 16 elite-lines and 4 cultivars (total of 20 genotypes)
#' were evaluated in the crop season of 2004 and 2005 at 15 locations. Each trial was analyzed in
#' randomized complete block design, with four replications, and based on plot consisted of five rows
#' of 5,0 m spaced at 0.3 m, with seeding density of 60 seeds.m-1.
#' Crop management and sowing dates were performed according to the current farmer management at
#' region where each trial was conducted. This experimental design and trial management are standardized
#' for cultivar testing trials in upland rice breeding program of Embrapa.
#'@docType data
#'@usage data(rice1)
#'@examples
#' data(rice1); head(rice1)
#' @format A data frame with 300 rows and 6 variables:
#' \describe{
#'   \item{env}{environmental id (factor)}
#'   \item{gid}{genotypic id (factor)}
#'   \item{ggl}{value of genotype plus genotype by location interaction effects in kg ha-1 (numeric)}
#'   \item{Longitude}{Longitude covariate (in degrees) of the evaluated environmet scaled to mean equal 0 and variance equal 1}
#'   \item{Latitude}{Longitude covariate (in degrees)  of the evaluated environmet scaled to mean equal 0 and variance equal 1}
#'   \item{Elevation}{Longitude covariate (in meters  of the evaluated environmet above sea) scaled to mean equal 0 and variance equal 1}
#'   ...
#' }
"rice1"
