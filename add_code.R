FR.model = function(df.y, gid='gid', env='env', value='ggl', covs, intercept=TRUE){


  Y = df.y[,c(env,gid,value)]
  names(Y) = c("env","gid","value")
  Y$env = as.factor(Y$env)
  df.cov = data.frame(df.y[,covs])
  names(df.cov) = covs

  if(intercept == TRUE ){form="value~1"}
  if(intercept == FALSE){form="value~0"}

  nenv = nlevels(Y$env)

  for(LP in 1:length(names(df.cov))){form=paste(form,"+",names(df.cov)[LP],sep="")}

  form = as.formula(form)
  Y = cbind(Y,df.cov)
  out.coef = predK = out.ss   = NULL
  if(intercept == FALSE){modelK   = plyr::ddply(Y, .(gid), function(x) coef(lm(form,x)))}
  if(intercept == TRUE) {modelK   =  plyr::ddply(Y, .(gid), function(x) coef(lm(form,x)));names(modelK)[2]="Mean"}

  anovaK   =  plyr::ddply(Y, .(gid), function(x) data.frame(source=rownames(anova(lm(form,x))),anova(lm(form,x))))
  out.coef = rbind(out.coef ,data.frame(modelK))
  out.ss   = rbind(out.ss   ,data.frame(anovaK))

  (ss.1 = dcast(out.ss,formula = gid~source,value.var = "Mean.Sq"))
  (ss.1[,c(-1)] = ss.1[,c(-1)]/rowSums(ss.1[,-1]))


  return(list(coefficients=out.coef,sum.of.squares=out.ss,frac.ss=ss.1))
}
