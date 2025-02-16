poisson_model_1<- glm(hookup_sum ~ greek_group + greek_house + Age + Gender + Hisp + Black +Asian + Native + Mideast +  BMI + BMI2 + college_dad + college_mom + hookup_highschool + 
                       ParentsDivorce, data = collegehookup, family = poisson)
poisson_model_2<- glm(hookup_sum ~ greek_group + greek_house + Age + Gender + Hisp + Black +Asian + Native + Mideast +  BMI + BMI2 + college_dad + college_mom + hookup_highschool + 
                     ParentsDivorce + Siblings, data = collegehookup, family = poisson)

summary(poisson_model)
library(stargazer)
stargazer(poisson_model,poisson_model_2, 
          title = "Regression Model", 
          align = TRUE, 
          add.significance = TRUE, 
          style = "default", 
          digits = 4, 
          type = "latex", 
          out = "regression_table")
