# *frGIS*:**Tools for implementing geographic information systems (GIS) and factorial regression models (FR) on plant breeding**


##  Package overview
frGIS is a useful package for diagnostic recommendations for new cultivars and evaluating the phenotypic plasticity of germplasm against spatial variations over a target region. This package can also be used to support the targeting of products in pre-commercial material evaluation phases, guiding the effort allocation and resources management to priority target regions that demands most breeding efforts. Until now, this package only employes least-squares methods under the parametric point of view. Howerver, future updates will be focused on including iterative non-parametric methods, bayesian approaches, and ridge regressions. We are open to establishing partnerships in order to improve the tools achieved here. For those interested in contributing to the project, please get in touch with germano.cneto@usp.br

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
data(rice2)
head(rice2)

#' Factorial regression
#'--------------------------------------------------------------------------
output = FR.model(df.y = rice2,intercept = T)

output$coefficients   # genotypic coefficients
output$sum.of.squares # anova output for each genotype
output$frac.ss        # fraction of phenotypic variance explained by the effect of environment covariates

#' Cross-validation
#'--------------------------------------------------------------------------
output = FRcv(df.y = rice2,f = .1,part.env = 1,intercept = T,boot=1E3) # 1000-boot, leaving one environment out plus 10% of the genotypes

#- Examples
#'--------------------------------------------------------------------------
met1 = FRcv(df.y = rice1,f = .1,part.env = 1,intercept = T,boot=1E3)
met2 = FRcv(df.y = rice2,f = .1,part.env = 1,intercept = T,boot=1E3)

summary.FRcv(met1)$coefficients
summary.FRcv(met2)$coefficients

summary.FRcv(met1)$frac.ss
summary.FRcv(met1)$frac.ss

```

### Predicting yield adaptability trends (Surface trend analysis with yield adaptability)

```R
require(plyr)

# cov.coord = raster of environmental variables
coef.1 = dcast(summary.FRcv(met1)$coefficients, formula = gid~variable)
coef.2 = dcast(summary.FRcv(met2)$coefficients, formula = gid~variable)

output1 = predict.Ad(b=coef.1,cov.raster = cov.coord,intercept = T)
output2 = predict.Ad(b=coef.2,cov.raster = cov.coord,intercept = T)

```


# References

Costa-Neto, G.M.F., Morais Júnior, O.P., Heinemann, A.B. et al. A novel GIS-based tool to reveal spatial trends in reaction norm: upland rice case study. **Euphytica** 216, 37 (2020). https://doi.org/10.1007/s10681-020-2573-4

Martins, A. S. (2004). Aplicação de sistema de informações geográficas no estudo da interação genótipos com ambientes. Master's thesis in Agronomy, Escola de Agronomia e Engenharia de Alimentos. Universidade Federal de Goiás, Goiânia (in portuguese).

Costa-Neto, G. M. F. (2017). Integrating environmental covariates and thematic maps into genotype by environment interaction analysis in upland rice. Master's thesis in Genetics and Plant Breeding, Escola de Agronomia e Engenharia de Alimentos. Universidade Federal de Goiás, Goiânia

# Acknowledgements

This study was financed in part by the Coordenação de Aperfeiçoamento de Pessoal de Nível Superior - Brasil (CAPES) and Brazilian Agricultural Research Corporation. Special thanks for the researchers Alexandre Bryan Heinemann, phD and Adriano Pereira de Castro, phD for the co-authored support for this methodological development

