cov.by.trial <-function(cov.raster,reference, long, latd, trial){

  leg  = reference
  loc  = data.frame(x=leg[,long],y=leg[,latd])
  Site = leg[,trial]
  coordinates(loc)= ~x+y
  proj4string(loc) = CRS("+proj=longlat +datum=WGS84")
  
  for(i in 1:length(names(cov.raster))){Site = cbind(Site,data.frame(extract(cov.raster[[i]], loc)))}
  names(Site)[-1] = names(cov.raster)
  return(data.frame(unique(Site)))
}

