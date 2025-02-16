#a.)設立虛擬變數
mroz$mothercoll <- ifelse(mroz$mothereduc > 12, 1, 0)
mroz$fathercoll <- ifelse(mroz$fathereduc > 12, 1, 0)
1-mean(mroz$fathercoll==0&mroz$mothercoll==0)

#b.)計算相關係數
print(cor(mroz[c("educ","fathercoll","mothercoll")]))
print(cor(mroz[c("educ","fathereduc","mothereduc")]))

#c.)Method:2sls.Variable:exper,exper2,educ.Instrument:mothercoll.
library(ivreg)
mroz$expersq <- mroz$exper^2 #建立exper2
sls <- ivreg(wage ~ educ + exper + expersq | mothercoll+ exper + expersq, data = mroz)

#e.)f.) Method:2sls.Variable:exper,exper2,educ.Instrument:mothercoll,fathercoll
sls_new <- ivreg(wage ~ educ + exper + expersq | mothercoll+ fathercoll+ exper + expersq, data = mroz)

#g.) test overfitted and good enough 
summary(sls,diagnostics =TRUE)
summary(sls_new,diagnostics =TRUE)

#輸出表格
library(stargazer)
stargazer(sls,  
          title = "Regression Model 2SLS(mothercoll)", 
          add.significance = TRUE, 
          style = "default", 
          digits = 4, 
          type = "text",
          ci=TRUE,ci.level=0.95,
          single.row = TRUE,
          out = "regression_table.doc")

stargazer(sls_new,  
          title = "Regression Model 2SLS(mothercoll,fathercoll)", 
          add.significance = TRUE, 
          style = "default", 
          digits = 4, 
          type = "text",
          ci=TRUE,ci.level=0.95,
          single.row = TRUE,
          out = "regression_table.doc")

iv1<-lm(educ~mothercoll+exper + expersq,data=mroz)
summary(iv1)
iv2<-lm(educ~mothercoll+fathercoll+exper + expersq,data=mroz)
summary(iv2)

stargazer(iv1,  
          title = "Regression Model iv1", 
          add.significance = TRUE, 
          style = "default", 
          digits = 4, 
          type = "text",
          out = "regression_table.doc")

stargazer(iv2,  
          title = "Regression Model iv2", 
          add.significance = TRUE, 
          style = "default", 
          digits = 4, 
          type = "text",
          out = "regression_table.doc")

