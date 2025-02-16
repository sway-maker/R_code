ols<-lm((HS)~(y)+(RR),data=X4_10_補_)
summary(ols)
residuals <- resid(ols)
X4_10_補_$residual<-residuals

y<- 0
for (t in 5:113) {
  x <- (X4_10_補_$residual[t] - X4_10_補_$residual[t - 4])^2
  y <- y + x
}
z <- sum(X4_10_補_$residual^2)
result_normalized <- y /z
print(result_normalized)

lm_test<-bgtest(ols,order=4)
print(lm_test)

dw_test_result <- durbinWatsonTest(ols,max.lag=4)
print(dw_test_result)

u=X4_10_補_$residual
rho=sum(u[1:109]*u[5:113])/sum(u*u)

hildreth.lu<-function(HS,y,RR,rho){
  t<-5:113
  HSlag<-HS[t]-rho*HS[t-4]
  ylag<-y[t]-rho*y[t-4]
  RRlag<-RR[t]-rho*RR[t-4]
  return(lm(HSlag~ylag+RRlag,data=X4_10_補_))
}

for(k in 1:21){
  ols=hildreth.lu(X4_10_補_$HS, X4_10_補_$y, X4_10_補_$RR,-1.1+0.1*k)
  summary_model=summary(ols)
  c[k]=summary_model$sigma
  b[k]=-1.1+0.1*k
}
min_index<-which.min(c)
print(min_index)

for(k in 1:20){
  ols=hildreth.lu(X4_10_補_$HS, X4_10_補_$y, X4_10_補_$RR,-0.2+0.01*k)
  summary_model=summary(ols)
  c[k]=summary_model$sigma
  b[k]=-0.2+0.01*k
}
min_index<-which.min(c)
print(min_index)

ols=hildreth.lu(X4_10_補_$HS, X4_10_補_$y, X4_10_補_$RR,-0.14)
summary(ols)

stargazer(ols, 
          title = "差分 Model",
          align = TRUE,
          add.significance = TRUE,
          style = "default",
          digits = 4,
          type = "text",
          out = "regression_table.txt")