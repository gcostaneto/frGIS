#' Factorial Regression (FR) models with environmental or genotypic covariates
#'
#' Returns factorial regression from phenotypic and environmental data.
#' The number of phenotypic observations can not exceed the number of parameters
#' (coefficients of the genotypes for each covariate) to be estimated.
#' Note: the model is based on ordinary least squares (OLS) and multicollinearity effects
#' are not removed from the analysis.
#' Future updates of the function will allow FR modeling based on Bayesian inference (Gibbs-sampling) and partial least squares (PLS).
#'
#'
#' @param df.y is a data.frame containing the following colunms: environment (factor), genotype (factor), GxE or G+GxE effects (numeric) and covariates (numeric).
#' @param intercept  TRUE (default) or FALSE if considering include fixed genotypic intercept
#' @author  Germano M F Costa Neto

#' @references Costa Neto GMF. Integrating environmental covariates and thematic maps into genotype by environment interaction analysis in upland rice. Master degree Thesis in Genetics and Plant Breeding, Agronomy School, Federal University of Goiás. Brazil, 2017. 122f.
#' @references Van Eeuwijk FA. Linear and bilinear models for the analysis of multi-environment trials: I. An inventory of models. Euphytica. 1995;84(1):1–7.
#' @references Brancourt-Hulmel M, Denis JB, Lecomte C. Determining environmental covariates which explain genotype environment interaction in winter wheat through probe genotypes and biadditive factorial regression. Theor Appl Genet. 2000;100(2):285–98.
#' @references Balfourier F, Oliveira JA, Charmet G, Arbones E. Factorial regression analysis of genotype by environment interaction in ryegrass populations, using both isozyme and climatic data as covariates. Euphytica. 1997;98(1):37–46.
#' @references Baril CP, Denis J-B, Wustman R, Van Eeuwijk FA. Analysing genotype by environment interaction in Dutch potato variety trials using factorial regression. Euphytica. 1995;84(1):23–9.
#' @references Vargas M, Crossa J, Van Eeuwijk FA, Ramírez ME, Sayre K. Using partial least squares regression, factorial regression, and AMMI models for interpreting genotype x environment interaction. Crop Sci. 1999;39(4):955–67.


FR.model = function(df.y, intercept=TRUE){


  Y = df.y[,c(1,2,3)]
  names(Y) = c("env","gid","value")
  Y$env = as.factor(Y$env)
  df.cov = df.y[,-c(1:3)]

  if(intercept == TRUE ){form="value~1"}
  if(intercept == FALSE){form="value~0"}

  nenv = nlevels(Y$env)

  for(LP in 1:length(names(df.cov))){form=paste(form,"+",names(df.cov)[LP],sep="")}

  form = as.formula(form)
  Y = cbind(Y,df.cov)
  out.coef = predK = out.ss   = NULL
  if(intercept == FALSE){modelK   = plyr::ddply(Y, .(gid), function(x) coef(lm(form,x)))}
  if(intercept == TRUE) {modelK   =  plyr::ddply(Y, .(gid), function(x) coef(lm(form,x)));names(modelK)[2]="Mean"}
  anovaK   =  plyr::ddply(Y, .(gid), function(x) data.frame(source=rownames(anova(lm(form,x))),anova(lm(form,x))))
  out.coef = rbind(out.coef ,data.frame(modelK))
  out.ss   = rbind(out.ss   ,data.frame(anovaK))

  (ss.1 = dcast(out.ss,formula = gid~source,value.var = "Mean.Sq"))
  (ss.1[,c(-1)] = ss.1[,c(-1)]/rowSums(ss.1[,-1]))


  return(list(coefficients=out.coef,sum.of.squares=out.ss,frac.ss=ss.1))
}
