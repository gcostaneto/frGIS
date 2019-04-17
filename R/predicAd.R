#' predicting yield adaptability from genotypic sensibility coefficients and raster files.
#'
#'

#' @param cov.raster is a raster or a raster stack file for environmental covariates
#' @param coef  data.frame containing genotype id (gid) and genotypic sensibility coefficients
#' @param df.x data.frame containing environmental covarites per pixel (used when cov.raster is NULL)
#' @param yx data.frame containing geographic coordinates (latitude and longitude) per pixel (used when cov.raster is NULL)
#' @param intercept  TRUE (default) or FALSE if considering include fixed genotypic intercept
#' @author  Germano M F Costa Neto

predict.Ad = function(coef,cov.raster, df.x = NULL, yx=NULL,intercept=T){
  
  require(raster)
  coord  = yx
  
  if(is.null(df.x) == T){
    covall = rasterTodf(cov.raster)
    coord  = covall$coord
    df.x   = covall$df.x}
  df.x = data.frame(df.x)
  
  adp = predict.FR2(b = coef,intercept = intercept,new.trial = df.x)
  adp = cbind(coord,adp)
  return(adp)
}

