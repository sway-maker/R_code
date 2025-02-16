library(stargazer)
stargazer(probit_model1,  
          title = "Regression Model", 
          align = TRUE, 
          add.significance = TRUE, 
          style = "default", 
          digits = 4, 
          type = "text", 
          out = "regression_table")
