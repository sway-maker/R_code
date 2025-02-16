#1
model<-lm(y~d*n,data=Suicide)
summary(model)
library(stargazer)
install.packages("stargazer")
stargazer(model,
          title="did model",
          type = "text")

#10.18
library(plm)
model<-plm(lnprice~age+attractive+school+regular+rich+alcohol+nocondom+bar+street,data=mexican,model="pooling")
modelfe<-plm(lnprice~regular+rich+alcohol+nocondom+bar+street,data=mexican,model="within")
modelpl<-plm(lnprice~regular+rich+alcohol+nocondom+bar+street,data=mexican,model="pooling")

pFtest(modeltratiofe,modeltratio)
library(stargazer)
stargazer(modeldummy,
          title="ols and fixed effect model",
          type = "text",
          out="result.txt")

model<-plm(ly~lk+ll,data=ces,model="pooling")
modelt<-plm(ly~lk+ll+t,data=ces,model="pooling")
modeltratio<-plm(lyl~lkl+t,data=ces,model="pooling")
modeltfe<-plm(ly~lk+ll+t,data=ces,model="within")
modeltratiofe<-plm(lyl~lkl+t,data=ces,model="within")
modeldummy<-plm(ly~lk+ll+d2+d3+d4+d5+d6+d7+d8+d9+d10+d11+d12+d13+d14+d15+d16+d17
                +d18+d19+d20+d21+d22+d23+d24+d25+d26+d27+d28,data=ces,model="pooling")

linearHypothesis(modeltfe, c("lk + ll = 1"))
summary(modeltratiofe)



