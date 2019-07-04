predict.FR2=function(coef, new.trial, intercept=TRUE){
  coef = as.matrix(data.frame(coef,row.names=1))
  covb = as.matrix(data.frame(new.trial))
  if(intercept == TRUE){return(yHat=new.GA(cov = cbind(1,covb),coef = coef))}
  if(intercept == FALSE){return(yHat=new.GA(cov = covb,coef = coef))}
  
}

rasterTodf = function(x.raster){
  require(raster)
  .xraster = data.frame(rasterToPoints(x.raster))
  coord   = data.frame(.xraster[,c(1:2) ])
  .df.x    = data.frame(.xraster[,-c(1:2)])
  return(list(coord=coord,df.x=.df.x))
}
