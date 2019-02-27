# Predicting yield adaptability values for new locations



new.GA = function(cov, coef){
  predi <- as.matrix(cov)%*%t(coef)
  return(predi)
}


predict.FR = function(fr.model, new.trial, intercept=TRUE){
  coef = as.matrix(data.frame(fr.model$coefficients,row.names=1))
  covb = as.matrix(data.frame(new.trial,row.names = 1))
  if(intercept == TRUE){return(yHat=new.GA(cov = cbind(1,covb),coef = coef))}
  if(intercept == FALSE){return(yHat=new.GA(cov = covb,coef = coef))}
  
}