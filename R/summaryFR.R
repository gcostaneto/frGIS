


summary.FRcv = function(fr.object){
  require(Rmisc)
  NAMES = names(fr.object$coef.hat[c(2:(ncol(fr.object$coef.hat)-1))])
  frac_I = summarySE(melt(fr.object$frac.ss ,measure.vars = NAMES[-1]), measurevar="value",groupvars=c("variable","gid"))
  coef_I = summarySE(melt(fr.object$coef.hat,measure.vars = NAMES), measurevar="value",groupvars=c("variable","gid"))
  return(list(coefficients=coef_I,frac.ss=frac_I))
}

