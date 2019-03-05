#' Collection of environmental covariables from raster files and geographic coordinates.
#'
#' @param cov.raster is a raster or a raster stack object for environmental covariates
#' @param reference  is a data.frame object containing the identifiers of places (or environments) and their geographic coordinates of latitude and longitude.
#' @param long name of the longitude vector inserted in the reference data.frame
#' @param latd name of the latitude vector inserted in the reference data.frame
#' @param trial name of the trial vector inserted in the reference data.frame
#' @author  Germano M F Costa Neto


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

