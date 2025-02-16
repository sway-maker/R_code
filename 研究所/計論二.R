#1
set.seed(123)  
n <- 100 
alpha <- 1
beta1 <- 1
beta2 <- -2

x1 <- rnorm(n, mean = 2, sd = 1)            # x1 ~ N(2, 1)
x2 <- rpois(n, lambda = 4)                  # x2 ~ Poisson(4)
epsilon <- rnorm(n, mean = 0, sd = 1)       # ε ~ N(0, 1)
y <- alpha + beta1 * x1 + beta2 * x2 + epsilon

#2
model <- lm(y ~ x1 + x2)
summary(model)

theta_hat <- coef(model)
theta_hat_cov <- vcov(model)  

cat("OLS Estimates of θ: \n", theta_hat, "\n")
cat("Covariance Matrix of θ estimates: \n")
print(theta_hat_cov)

#3
x1_new <- rnorm(n, mean = 2, sd = 6)        # x1 ~ N(2, 36)
y_new <- alpha + beta1 * x1_new + beta2 * x2 + epsilon

model_new <- lm(y_new ~ x1_new + x2)
summary(model_new)

theta_hat_new <- coef(model_new)
theta_hat_cov_new <- vcov(model_new)

cat("OLS Estimates of θ with x1 ~ N(2, 36): \n", theta_hat_new, "\n")
cat("Covariance Matrix of θ estimates with x1 ~ N(2, 36): \n")
print(theta_hat_cov_new)

cat("Variance of estimates comparison: \n")
cat("Original x1 ~ N(2, 1):\n", diag(theta_hat_cov), "\n")
cat("Modified x1 ~ N(2, 36):\n", diag(theta_hat_cov_new), "\n")

#4
theta_hats <- matrix(NA, 1000, 3) 

for (b in 1:1000) {
  x1 <- rnorm(n, mean = 2, sd = 1)
  x2 <- rpois(n, lambda = 4)
  epsilon <- rnorm(n, mean = 0, sd = 1)
  
  y <- alpha + beta1 * x1 + beta2 * x2 + epsilon
  model <- lm(y ~ x1 + x2)
  theta_hats[b, ] <- coef(model)
}

#plot
par(mfrow = c(1, 3))  

hist_alpha <- hist(theta_hats[, 1], breaks = 20, plot = FALSE)
y_max_alpha <- max(hist_alpha$density, dnorm(hist_alpha$mids, mean = alpha, sd = sqrt(vcov(model)[1,1])))
xlim_alpha <- range(c(hist_alpha$breaks, qnorm(c(0.001, 0.999), mean = alpha, sd = sqrt(vcov(model)[1,1]))))
hist(theta_hats[, 1], breaks = 20, probability = TRUE, main = expression(hat(alpha)),
     xlab = expression(hat(alpha)), col = "#00CED1", ylim = c(0, y_max_alpha), xlim = xlim_alpha)
curve(dnorm(x, mean = alpha, sd = sqrt(vcov(model)[1,1])), add = TRUE, col = "red", lwd = 2)

hist_beta1 <- hist(theta_hats[, 2], breaks = 20, plot = FALSE)
y_max_beta1 <- max(hist_beta1$density, dnorm(hist_beta1$mids, mean = beta1, sd = sqrt(vcov(model)[2,2])))
xlim_beta1 <- range(c(hist_beta1$breaks, qnorm(c(0.001, 0.999), mean = beta1, sd = sqrt(vcov(model)[2,2]))))
hist(theta_hats[, 2], breaks = 20, probability = TRUE, main = expression(hat(beta)[1]),
     xlab = expression(hat(beta)[1]), col = "#FFB6C1", ylim = c(0, y_max_beta1), xlim = xlim_beta1)
curve(dnorm(x, mean = beta1, sd = sqrt(vcov(model)[2,2])), add = TRUE, col = "red", lwd = 2)

hist_beta2 <- hist(theta_hats[, 3], breaks = 20, plot = FALSE)
y_max_beta2 <- max(hist_beta2$density, dnorm(hist_beta2$mids, mean = beta2, sd = sqrt(vcov(model)[3,3])))
xlim_beta2 <- range(c(hist_beta2$breaks, qnorm(c(0.001, 0.999), mean = beta2, sd = sqrt(vcov(model)[3,3]))))
hist(theta_hats[, 3], breaks = 20, probability = TRUE, main = expression(hat(beta)[2]),
     xlab = expression(hat(beta)[2]), col = "skyblue2", ylim = c(0, y_max_beta2), xlim = xlim_beta2)
curve(dnorm(x, mean = beta2, sd = sqrt(vcov(model)[3,3])), add = TRUE, col = "red", lwd = 2)

par(mfrow = c(1, 1))

