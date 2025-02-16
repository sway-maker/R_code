#16.24
sum(cex5$appar==0.00)/2334

lm1<- lm(appar~income+smsa+advanced+college+older,data=cex5)
summary(lm1)

library(dplyr)
library(magrittr) 
cex5_2<-cex5 %>% filter(appar>0)
lm2<- lm(appar~income+smsa+advanced+college+older,data=cex5_2)
summary(lm2)

cex5_3<-cex5%>%
  mutate(shop=ifelse(appar>0,1,0))
lm3<-glm(shop~income+smsa+advanced+college+older,data=cex5_3,family = binomial(link="probit"))
summary(lm3)

library(AER)
lm4<-tobit(appar ~ income + smsa + advanced + college + older,data=cex5)
summary(lm4)

margin1<-0.2206*pnorm((0.2206*650+11.16446+22.52243-24.78810)/60.14)
margin2<-0.2206*pnorm((0.2206*1250+11.16446+22.52243-24.78810)/60.14)



library(stargazer)
stargazer(lm4,
          title = "Regression Model", 
          align = TRUE, 
          add.significance = TRUE, 
          style = "default", 
          digits = 4, 
          type = "text")
