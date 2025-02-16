##16.19
#跑lm with robust standard error
library(lmtest)
library(sandwich)
lm_model1<-lm(default~arm+refinance+lien2+term30+underwater+ltv+rate+amount+fico,data=vegas5_small)
summary(lm_model1)
a<-coeftest(lm_model1, vcov = vcovHC(lm_model1, type = 'HC0'))

#跑probit
probit_model1<-glm(default~arm+refinance+lien2+term30+underwater+ltv+rate+amount+fico,data=vegas5_small,binomial(link="probit"))
summary(probit_model1)

#計算不同模型下的機率
lm_predicted_value_condition1 <- predict(lm_model1, newdata=vegas5_small[500,])
lm_predicted_value_condition2 <- predict(lm_model1, newdata=vegas5_small[1000,])
pb_predicted_value_condition1 <- predict(probit_model1,newdata=vegas5_small[500,])
pb_predicted_value_condition2 <- predict(probit_model1,newdata=vegas5_small[1000,])
#變成表格
predictions_table <- cbind(
  lm_model500th = lm_predicted_value_condition1,
  lm_model1000th = lm_predicted_value_condition2,
  probit_model500th = pb_predicted_value_condition1,
  probit_model1000th = pb_predicted_value_condition2
)

#建立fico的直方圖
hist(predictions_table, main = "Histogram of fico", xlab = "fico", ylab = "value")

#給定條件算機率(fico)
lm_predicted_probabilities_500 <- predict(lm_model1, type = "response",newdata=data.frame(fico=500,amount=25,ltv=80,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
lm_predicted_probabilities_600 <- predict(lm_model1, type = "response",newdata=data.frame(fico=600,amount=25,ltv=80,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
lm_predicted_probabilities_700 <- predict(lm_model1, type = "response",newdata=data.frame(fico=700,amount=25,ltv=80,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
pb_predicted_probabilities_500 <- predict(probit_model1, type = "response",newdata=data.frame(fico=500,amount=25,ltv=80,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
pb_predicted_probabilities_600 <- predict(probit_model1, type = "response",newdata=data.frame(fico=600,amount=25,ltv=80,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
pb_predicted_probabilities_700 <- predict(probit_model1, type = "response",newdata=data.frame(fico=700,amount=25,ltv=80,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
#變成表格
predictions_table <- cbind(
  lm_500 = lm_predicted_probabilities_500,
  lm_600 = lm_predicted_probabilities_600,
  lm_700 = lm_predicted_probabilities_700,
  pb_500 = pb_predicted_probabilities_500,
  pb_600 = pb_predicted_probabilities_600,
  pb_700 = pb_predicted_probabilities_700
)
#
barplot(c(lm_predicted_probabilities_500,lm_predicted_probabilities_600,lm_predicted_probabilities_700), 
        names.arg = c("FICO 500", "FICO 600", "FICO 700"), 
        main = "Predicted Probabilities for Different FICO Scores",
        xlab = "FICO Score",
        ylab = "Predicted Probability",
        col = "blue",
        ylim = c(0, 1))
barplot(c(pb_predicted_probabilities_500,pb_predicted_probabilities_600,pb_predicted_probabilities_700), 
        names.arg = c("FICO 500", "FICO 600", "FICO 700"), 
        main = "Predicted Probabilities for Different FICO Scores",
        xlab = "FICO Score",
        ylab = "Predicted Probability",
        col = "red",
        ylim = c(0, 1))


#建立ltv的直方圖
hist(vegas5_small$ltv, main = "Histogram of ltv", xlab = "ltv", ylab = "value")

#給定條件算機率(ltv)
lm_predicted_probabilities_20 <- predict(lm_model1, type = "response",newdata=data.frame(fico=600,amount=25,ltv=20,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
lm_predicted_probabilities_80 <- predict(lm_model1, type = "response",newdata=data.frame(fico=600,amount=25,ltv=80,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
pb_predicted_probabilities_20 <- predict(probit_model1, type = "response",newdata=data.frame(fico=600,amount=25,ltv=20,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
pb_predicted_probabilities_80 <- predict(probit_model1, type = "response",newdata=data.frame(fico=600,amount=25,ltv=80,rate=8,term30=1,arm=0,refinance=0,lien2=0,underwater=0))
predictions_table <- cbind(
  lm_20 = lm_predicted_probabilities_20,
  lm_80 = lm_predicted_probabilities_80,
  pb_20 = pb_predicted_probabilities_20,
  pb_80 = pb_predicted_probabilities_80
)
#
barplot(c(lm_predicted_probabilities_20,lm_predicted_probabilities_80), 
        names.arg = c("LTV20",  "LTV80"), 
        main = "Predicted Probabilities for Different LTV Scores",
        xlab = "LTV Score",
        ylab = "Predicted Probability",
        col = "blue",
        ylim = c(0, 1))
barplot(c(pb_predicted_probabilities_20,pb_predicted_probabilities_80), 
        names.arg = c("LTV20",  "LTV80"), 
        main = "Predicted Probabilities for Different LTV Scores",
        xlab = "LTV Score",
        ylab = "Predicted Probability",
        col = "red",
        ylim = c(0, 1))

#算模型的正確率
#for lm
predicted_probabilities_lm1 <- predict(lm_model1, newdata = vegas5_small, type = "response")
predicted_classes_lm1 <- ifelse(predicted_probabilities_lm1 > 0.5, 1, 0)
table_lm1<-data.frame(table(true=vegas5_small$default,
                           predicted=predicted_classes_lm1))
#for probit
predicted_probabilities_pb1 <- predict(probit_model1, newdata = vegas5_small, type = "response")
predicted_classes_pb1 <- ifelse(predicted_probabilities_pb1 > 0.5, 1, 0)
table_pb1<-data.frame(table(true=vegas5_small$default,
                            predicted=predicted_classes_pb1))

#算模型的正確率(用前500當訓練集)
probit_model2<-glm(default~arm+refinance+lien2+term30+underwater+ltv+rate+amount+fico,data=vegas5_small[1:500,],binomial(link="probit"))
logit_model1<-glm(default~arm+refinance+lien2+term30+underwater+ltv+rate+amount+fico,data=vegas5_small[1:500,],binomial(link="logit"))
lm_model2<-lm(default~arm+refinance+lien2+term30+underwater+ltv+rate+amount+fico,data=vegas5_small[1:500,])

#for probit
predicted_probabilities_pb <- predict(probit_model2, newdata = vegas5_small[501:1000,], type = "response")
predicted_classes_pb <- ifelse(predicted_probabilities_pb > 0.5, 1, 0)
table_pb<-data.frame(table(true=vegas5_small[501:1000,]$default,
                           predicted=predicted_classes_pb))
#for lm
predicted_probabilities_lm <- predict(lm_model2, newdata = vegas5_small[501:1000,], type = "response")
predicted_classes_lm <- ifelse(predicted_probabilities_lm > 0.5, 1, 0)
table_lm<-data.frame(table(true=vegas5_small[501:1000,]$default,
                           predicted=predicted_classes_lm))
#for logit
predicted_probabilities_lg <- predict(logit_model1, newdata = vegas5_small[501:1000,], type = "response")
predicted_classes_lg <- ifelse(predicted_probabilities_lg > 0.5, 1, 0)
table_lg<-data.frame(table(true=vegas5_small[501:1000,]$default,
                           predicted=predicted_classes_lg))



##16.28
#建立demwin dummy
fair5$DEMWIN <- ifelse(fair5$vote >= 50.0 , 1,0)
probit_1<-glm(DEMWIN~growth+inflat+goodnews,data=fair5[fair5$year!=2016,],family=binomial(link="probit"))  #用2016之前的資料
summary(probit_1)

#要預測damocrat勝率
predicted_probabilities <- predict(probit_1, type = "response",newdata=data.frame(growth=0.97,inflat=1.42,goodnews=2))
predicted_probabilities

#加入dper,dur,war,incumb
probit_2<-glm(DEMWIN~growth+inflat+goodnews+dper+dur+war+incumb,data=fair5[fair5$year!=2016,],family=binomial(link="probit"))  #用2016之前的資料
summary(probit_2)

#預測1916~2012的機率，看有沒有非常接近0,1的值
predicted_value <- predict(probit_2,type = "response")
as.data.frame(predicted_probabilities)
p_near1 <- sum(predicted_value > 0.99999)
p_near0 <- sum(predicted_value < 0.00001)
print(p_near1+p_near0)

#抓出特定條件下的demwin值
predicted_value <- predict(probit_2, newdata=fair5[fair5$dper==-1&fair5$dur==0&fair5$war==0&fair5$incumb==-1,])
fair5[fair5$dper==-1&fair5$dur==0&fair5$war==0&fair5$incumb==-1,]



##16.30
#建立insured dummy
rwm88$INSURED <- ifelse(rwm88$public == 0 & rwm88$addon == 0, 1,
                            ifelse(rwm88$public == 1 & rwm88$addon == 0, 2,
                                   ifelse(rwm88$public == 1 & rwm88$addon == 1, 3 ,NA)))
table(rwm88$INSURED)

#multinomial
install.packages("nnet")
library(nnet)
multinomial_1<-multinom(INSURED~age+female+working+hhninc2,data=rwm88)
summary(multinomial_1)

#預測樣本落在三個組別的機率
#樣本
predicted_probabilities <- predict(multinomial_1, type = "probs")
average_probabilities <- apply(predicted_probabilities, 2, mean)
average_probabilities
#母體
probability_counts <- table(rwm88$INSURED)
probability_proportions <- probability_counts / 4483

#計算給訂條件下，落在三個組別的機率
predicted_probabilities_condition1 <- predict(multinomial_1, type = "probs",newdata=data.frame(age=50,female=1,working=1,hhninc2=2400))
predicted_probabilities_condition1

predicted_probabilities_condition2 <- predict(multinomial_1, type = "probs",newdata=data.frame(age=50,female=1,working=1,hhninc2=4200))
predicted_probabilities_condition2

#計算hhninc2的第25&75百分位數
quantile(rwm88$hhninc2, probs = 0.25)
quantile(rwm88$hhninc2, probs = 0.75)

library(stargazer)
stargazer(a,  
          title = "Regression Model", 
          align = TRUE, 
          add.significance = TRUE, 
          style = "default", 
          digits = 4, 
          type = "text", 
          out = "regression_table")



