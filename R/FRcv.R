#' Cross-validation scheme for FR models
#'
#'

#' @param df.y is a data.frame containing the following colunms: environment (factor), genotype (factor), GxE or G+GxE effects (numeric) and covariates (numeric).
#' @param intercept  TRUE (default) or FALSE if considering include fixed genotypic intercept
#' @param f is a fraction of genotypes that must be used as validation set (default f = 0.2, i.e., 20%)
#' @param part.env is the number of environments that be leave out of the training set (0 > part.env > number of environments). Default is 1 (leave-one-out scheme).
#' @param boot is the number of boots (default is equal to 1000)
#' @param path.output is the directorie used for output files
#' @author  Germano M F Costa Neto
#'
FRcv = function(df.y, f = .2 , part.env = 1,intercept=TRUE,boot=1E3,seed=3412,path.output=getwd()){
  set.seed(seed)
  frac.ss= coef.hat = ss.hat   =  yHat = NULL

  for(REP in 1:boot){
    cat(paste("running boot ",REP,"\n",sep=""))
    Model    = FR.sampling(df.y = df.y,f = f,part.env = part.env,intercept = intercept)
    yHat     = rbind(yHat,    data.frame(Model$yHat,          boot=REP))
    ss.hat   = rbind(ss.hat,  data.frame(Model$sum.of.squares,boot=REP))
    coef.hat = rbind(coef.hat,data.frame(Model$coefficients,  boot=REP))
    frac.ss  = rbind(frac.ss, data.frame(Model$frac.ss,       boot=REP))
    set.seed(seed+REP)
  }
  cat(paste("Ending bootstrap at ",Sys.time(),"\n",sep=""))
  saveRDS(yHat,       paste("yHat_boot:",boot,sep=""))
  saveRDS(coef.hat,   paste("coefficients_boot:",boot,sep=""))
  saveRDS(ss.hat,     paste("sumOfsquares_boot:",boot,sep=""))
  saveRDS(frac.ss,    paste("fracSS_boot:",boot,sep=""))

  return(list(yHat=yHat,ss.hat=ss.hat,coef.hat=coef.hat,frac.ss=frac.ss))
}
