#' Predicting yield adaptability values for new locations
#'
#'
#'
#' @param fr.model is a object containing FR.model output.
#' @param new.trial is a dataframe containing geographic covariates of new trials
#' @param intercept  TRUE (default) or FALSE if considering include fixed genotypic intercept
#' @author  Germano M F Costa Neto


predict.FR = function(fr.model, new.trial, intercept=TRUE){
  coef = as.matrix(data.frame(fr.model$coefficients,row.names=1))
  covb = as.matrix(data.frame(new.trial,row.names = 1))
  if(intercept == TRUE){return(yHat=new.GA(cov = cbind(1,covb),coef = coef))}
  if(intercept == FALSE){return(yHat=new.GA(cov = covb,coef = coef))}

}
