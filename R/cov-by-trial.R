#' Collects environmental covariables from rasters files and geographic information
#'
#'
#'
#' @param cov.raster is a raster stack object containing layers of environmental covariates
#' @param reference is a data.frame containing geographic coordinate information for each location or test to be sampled
#' @param latd  is a latitude reference vector within referebce data.frame
#' @param long  is a latitude reference vector within referebce data.frame
#' @param trial  is a trial or locaion id within referebce data.frame
#' @author  Germano M F Costa Neto


cov.by.trial <-function(cov.raster,reference, long, latd, trial){

  leg  = reference
  loc  = data.frame(x=leg[,long],y=leg[,latd])
  Site = leg[,trial]
  coordinates(loc)= ~x+y
  proj4string(loc) = CRS("+proj=longlat +datum=WGS84")

  for(i in 1:length(names(cov.raster))){Site = cbind(Site,data.frame(extract(cov.raster[[i]], loc)))}
  names(Site)[-1] = names(cov.raster)
  ret8urn(data.frame(unique(Site)))
}

