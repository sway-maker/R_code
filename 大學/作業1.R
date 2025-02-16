library("systemfit")
beef <- p1 ~ qb + qp + qc + y
pork <- p2 ~ qb + qp + qc + y
chicken <- p3 ~ qb + qp + qc + y
full <- list( p1=beef, p2=pork ,p3=chicken )

fitols <- systemfit(full, data = X8_2)
print(fitols)

restrict <- c( "p1_qp= p2_qb ",
               "p1_qc=p3_qb ",
               "p2_qc=p3_qp" )

fitsurRegMat <- systemfit(full, method = "SUR",
                          restrict.matrix = restrict , data=X8_2)
print(fitsurRegMat)

coefficients_matrix <- coef(fitsurRegMat)
result_table <- data.frame(Coefficients = coefficients_matrix)
print(result_table)


