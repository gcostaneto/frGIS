# frGIS
Yield adaptability analysis based on factorial regression and environmental covariates.

FRgis is a useful package for breeders and statisticians interested in guiding diagnostic recommendations for new cultivars and evaluating the phenotypic plasticity of germplasm against spatial variations in a given region. This package can also be used to support the targeting of products in pre-commercial material evaluation phases, guiding the allocation of effort and resources to priority target regions.

# Install

library(devtools);

install_github("gcostaneto/frGIS")

# Basic usage
```R
require(frGIS)
data(rice2)
output = FRcv(df.y = rice.2,f = .1,part.env = 1,intercept = T,boot=1E3)
```
## Package overview 

The methodology of factorial regression integrated with thematic maps was proposed by Martins (2004) in his master's thesis at the Federal University of Goiás (UFG, Goias, Brazil), under the supervision of Professor João Batista Duarte, phD (jbduarte@ufg.br). The method was expanded by Costa-Neto (2017) in his master's thesis at UFG-Embrapa (Brazilian Agricultural Research Corporation) partnership reaching the current molds. Currently this author is also responsible for the updates and maintenance of this package (germano.cneto@usp.br)

## References

Martins, A. S. (2004). Aplicação de sistema de informações geográficas no estudo da interação genótipos com ambientes. Mestrado em Agronomia, Escola de Agronomia e Engenharia de Alimentos. Universidade Federal de Goiás, Goiânia (in portuguese).

Costa-Neto, G. M. F. (2017). Integrating environmental covariates and thematic maps into genotype by environment interaction analysis in upland rice. Federal University of Goiás. Brazil.


# Acknowledgements

This study was financed in part by the Coordenação de Aperfeiçoamento de Pessoal de Nível Superior - Brasil (CAPES) and Brazilian Agricultural Research Corporation
