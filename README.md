# frGIS
Yield adaptability analysis based on factorial regression and environmental covariates.

##  Package overview 
frGIS is a useful package for breeders and statisticians interested in guiding diagnostic recommendations for new cultivars and evaluating the phenotypic plasticity of germplasm against spatial variations in a given region. This package can also be used to support the targeting of products in pre-commercial material evaluation phases, guiding the allocation of effort and resources to priority target regions.

## Background

The methodology of factorial regression integrated with thematic maps was proposed by Martins (2004) in his master's thesis at the Federal University of Goiás (UFG, Goias, Brazil), under the supervision of Professor João Batista Duarte (jbduarte@ufg.br). The method was expanded by Costa Neto (2017) in his master's thesis at UFG-Embrapa (Brazilian Agricultural Research Corporation), with Alexandre Bryan Heinemann advices for reaching the current molds. Currently this author is also responsible for the updates and maintenance of this package (germano.cneto@usp.br)

# Install
```R
library(devtools)
install_github("gcostaneto/frGIS")
```
# Basic usage

### Factorial Regression with geographic covariates

```R
require(frGIS)

#' data set
#'--------------------------------------------------------------------------
data(rice1) # upland rice data set
head(rice1)

#' Factorial regression
#'--------------------------------------------------------------------------
output = FR.model(df.y = rice1,intercept = T)

output$coefficients   # genotypic coefficients
output$sum.of.squares # anova output for each genotype
output$frac.ss        # fraction of phenotypic variance explained by the effect of environment covariates

### Other functions

The rest of the functions are being updated. Soon we will update the page.

# References

Martins, A. S. (2004). Aplicação de sistema de informações geográficas no estudo da interação genótipos com ambientes. Mestrado em Agronomia, Escola de Agronomia e Engenharia de Alimentos. Universidade Federal de Goiás, Goiânia (in portuguese).

Costa Neto, G. M. F. (2017). Integrating environmental covariates and thematic maps into genotype by environment interaction analysis in upland rice. Mestrado em Agronomia, Escola de Agronomia e Engenharia de Alimentos. Universidade Federal de Goiás, Goiânia

# Acknowledgements

This study was financed in part by the Coordenação de Aperfeiçoamento de Pessoal de Nível Superior - Brasil (CAPES) and Brazilian Agricultural Research Corporation. Special thanks for the researchers Alexandre Bryan Heinemann, phD and Adriano Pereira de Castro, phD for the co-authored support for this methodological development
