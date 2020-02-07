#' Build up raster stack files of environmental covariables
#'
#' @param raster.file a raster stack (see raster package) file containig longitude, latitude and elevation information
#' @param layer.names the name of raster files in raster.file
#' @param main title for main raster
#' @param scale T or F indicating if data need scaling
#' @crs CRS type. if null, assumes WGS84
#' @author  Germano M F Costa Neto

geo.rasters=function(raster.file,layer.names=c("Longitude","Latitude","Elevation"),
                     main="Elevation",
                     scale = T,
                     crs=NULL){
  if(is.null(crs)){crs <- "+proj=longlat +ellps=WGS84 +no_defs"}
  DFMATRIX = rasterToPoints(raster.file)
  DFMATRIX = data.frame(y=DFMATRIX[,1],x=DFMATRIX[,2],a=DFMATRIX[,3])
  colnames(DFMATRIX)[3] = main
  OUTraster = NULL

  (mean.list = rep(0,length(layer.names)))

  if(scale == TRUE){for(K in 1:length(layer.names)){mean.list[[K]] = mean(DFMATRIX[,K])}}

  for(W in 1:length(layer.names)){

    df.geo = data.frame(DFMATRIX[,c(1:2)],a=(DFMATRIX[,W]-mean.list[[W]]))
    # colnames(df.geo)[3] = layer.names[W]
    coordinates(df.geo)=~y+x
    proj4string(df.geo)=proj4string(raster.file)
    gridded(df.geo) <- TRUE
    if(W == 1){OUTraster = raster(df.geo)}else{
      OUTraster = stack(OUTraster,raster(df.geo))
    }
  }
  names(OUTraster) = layer.names
  return(OUTraster)
}

new.GA = function(cov, coef){
  predi <- as.matrix(cov)%*%t(coef)
  return(predi)
}

