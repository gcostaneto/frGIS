#' ploting yield adaptability maps from raster files
#'
#'

#' @param dp.raster is a raster or a raster stack file for predicted adp values of the genotypes.
#' @param nclass  numeric, is a number of classes for legend values
#' @param plot is a type of plot, using all values (full range), only positive values (positive) or negative (negative)
#' @param shp is a additional shape file

#' @author  Germano M F Costa Neto

plot.adp = function(adp.raster, nclass = 10, plot=c("full range","positive","negative"), 
                    shp=NULL,
                    p.strip = list(cex = 0.7, lines = 1, col = "black"),
                    colours = c("blue3","royalblue","cyan2","green3","yellow","red")){
  
  if(plot =="full range"){
    leg = c(round(seq(round(min(minValue(adp.raster)), 0), max(maxValue(adp.raster),0), len = nclass)))
  }
  if(plot == "positive") {
    leg = c(round(min(minValue(adp.raster)), 0), round(seq(0, max(maxValue(adp.raster),0), len = nclass), 0))
  }
  
  require(rasterVis)
  col = colorRampPalette(colours)
  levelplot(adp.raster,col.regions=col(nclass), at=leg)
  
}