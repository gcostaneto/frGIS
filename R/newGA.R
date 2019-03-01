new.GA = function(cov, coef){
  predi <- as.matrix(cov)%*%t(coef)
  return(predi)
}
