creat.int = function(cov.raster){
  int = cov.raster[[1]]
  values(int)[which(values(int > -Inf))] = 1
  new.cov = stack(int,cov.raster)
  names(new.cov) = c("MGV",names(cov.raster))
  return(new.cov)
  
}