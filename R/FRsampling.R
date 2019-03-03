#' Sampling tools for cross-validation
#'
#'
#'
#' @param df.y is a data.frame containing the following colunms: environment (factor), genotype (factor), GxE or G+GxE effects (numeric) and covariates (numeric).
#' @param intercept  TRUE (default) or FALSE if considering include fixed genotypic intercept
#' @param f is a fraction of genotypes that must be used as validation set (default f = 0.2, i.e., 20%)
#' @param part.env is the number of environments that be leave out of the training set (0 > part.env > number of environments). Default is 1 (leave-one-out scheme).
#' @param boot is the number of boots (default is equal to 1000)
#' @path.output is the directorie used for output files
#' @author  Germano M F Costa Neto


FR.sampling = function(df.y, f = .2 , part.env = 1,intercept=TRUE){
  require(reshape2)
  Y = df.y[,c(1,2,3)]
  names(Y) = c("env","gid","value")
  Y$env = as.factor(Y$env)
  Y$gid = as.factor(Y$gid)
  df.cov = df.y[,-c(1:3)]

  ENVS<-nlevels(Y$env)
  GIDS <- nlevels(Y$gid)
  Y = cbind(Y,df.cov)

  cvp = unique.data.frame(Y[,c(1,4:ncol(Y))])

  Ycopy    = Y
  tenv     =  as.character(unique(Ycopy$env)[sample(1:ENVS, size = part.env, replace = TRUE)])
  Ycopy$value[(Ycopy$env %in% tenv)] <- NA

  tgid     = as.character(unique(Ycopy$gid)[sample(1:GIDS, size = round(GIDS * f), replace = TRUE)])
  Ycopy$value[(Ycopy$gid %in% tgid)] <- NA

  Ycopy    = Ycopy[complete.cases(Ycopy),]

  out.p    = FR.model(df.y = Ycopy,intercept = intercept)

  yHat     = data.frame(melt(predict.FR(out.p,cvp,intercept = intercept)))
  names(yHat)  = c("env","gid","yHat")
  yHat = data.frame(merge(yHat,Y,by=c("env","gid")),pop=NA)
  yHat$pop[( yHat$env %in% tenv )  &   (yHat$gid %in% tgid)]   = "New MET"
  yHat$pop[ (yHat$env %in% tenv )  &  !(yHat$gid %in% tgid)]   = "New Location"
  yHat$pop[!(yHat$env %in% tenv )  &   (yHat$gid %in% tgid)]   = "New Genotype"
  yHat$pop[!( yHat$env %in% tenv)  &  !(yHat$gid %in% tgid)]   = "Within MET"


  return(list(yHat=yHat,sum.of.squares=out.p$'sum.of.squares',coefficients=out.p$'coefficients',frac.ss=out.p$"frac.ss"))

}
