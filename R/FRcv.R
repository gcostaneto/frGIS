#' Cross-validation scheme for FR models
#'
#' Returns predicted G
#' ates of the function will allow FR modeling based on Bayesian inference (Gibbs-sampling) and partial least squares (PLS).
#'
#'


FRcv = function(df.y, f = .2 , part.env = 1,intercept=TRUE,boot=1E3,seed=3412){
  set.seed(seed)
  frac.ss= coef.hat = ss.hat   =  yHat = NULL

  for(REP in 1:boot){
    Model    = FR.sampling(df.y = df.y,f = f,part.env = part.env,intercept = intercept)
    yHat     = rbind(yHat,    data.frame(Model$yHat,          boot=REP))
    ss.hat   = rbind(ss.hat,  data.frame(Model$sum.of.squares,boot=REP))
    coef.hat = rbind(coef.hat,data.frame(Model$coefficients,  boot=REP))
    frac.ss  = rbind(frac.ss, data.frame(Model$frac.ss,       boot=REP))
    set.seed(seed+REP)
  }
  return(list(yHat=yHat,ss.hat=ss.hat,coef.hat=coef.hat,frac.ss=frac.ss))
}
