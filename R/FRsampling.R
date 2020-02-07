FR.sampling = function(df.y, f = .2 , part.env = 1,intercept=TRUE){
require(reshape2)
require(plyr)
  
  Y = df.y[,c(1,2,3)]
  names(Y) = c("env","gid","value")
  Y$env = as.factor(Y$env)
  Y$gid = as.factor(Y$gid)
  df.cov = df.y[,-c(1:3)]

  ENVS<-nlevels(Y$env)
  GIDS <- nlevels(Y$gid)
  Y = cbind(Y,df.cov)

  cvp = unique.data.frame(Y[,c(1,4:ncol(Y))])

  Ycopy    = Y
  tenv     =  unique(Ycopy$env)[sample(1:ENVS, size = part.env, replace = TRUE)]
  Ycopy$value[(Ycopy$env %in% tenv)] <- NA

  tgid     = unique(Ycopy$gid)[sample(1:GIDS, size = round(GIDS * f), replace = TRUE)]
  Ycopy$value[(Ycopy$gid %in% tgid)] <- NA

  Ycopy    = Ycopy[complete.cases(Ycopy),]

  out.p    = FR.model(df.y = Ycopy,intercept = intercept)

  yHat     = data.frame(melt(predict.FR(out.p,cvp,intercept = intercept)),pop=NA)
  names(yHat)  = c("env","gid","yHat")
  yHat = merge(yHat,Y,by=c("env","gid"))
  yHat$pop[( yHat$env %in% tenv)  &   (yHat$gid %in% tgid)]   = "New GxL"
  yHat$pop[ (yHat$env %in% tenv)  &  !(yHat$gid %in% tgid)]   = "New L|Know G"
  yHat$pop[!(yHat$env %in% tenv)  &   (yHat$gid %in% tgid)]   = "Know L|New G"
  yHat$pop[!( yHat$env %in% tenv) &  !(yHat$gid %in% tgid)]   = "Know GxL"



  return(list(yHat=yHat,sum.of.squares=out.p$'sum.of.squares',coefficients=out.p$'coefficients',frac.ss=out.p$"frac.ss"))

}

predict.FR2=function(coef, new.trial, intercept=TRUE){
  coef = as.matrix(data.frame(coef,row.names=1))
  covb = as.matrix(data.frame(new.trial))
  if(intercept == TRUE){return(yHat=new.GA(cov = cbind(1,covb),coef = coef))}
  if(intercept == FALSE){return(yHat=new.GA(cov = covb,coef = coef))}

}

rasterTodf = function(x.raster){
  .xraster = data.frame(rasterToPoints(x.raster))
  coord   = data.frame(.xraster[,c(1:2) ])
  .df.x    = data.frame(.xraster[,-c(1:2)])
  return(list(coord=coord,df.x=.df.x))
}

