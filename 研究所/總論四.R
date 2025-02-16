library(Deriv)
library(ggplot2)

A <- 1
A_new <- 1.1
delta <- 0.5
theta <- 0.8
beta <- 0.95
alpha <- 0.5
u <- function(c, theta) (c^(1 - theta)-1)/(1 - theta) 
f <- function(k, alpha, A) A*k^alpha
f_prime <- function(k ,alpha ,A) alpha* A * k^(alpha - 1)

k_star_old <- (((1/beta)-(1-delta)) / (alpha*A))^(1/(alpha-1))
k_star_new <- (((1/beta)-(1-delta)) / (alpha*A_new))^(1/(alpha-1))
c_star_old <- f(k_star_old , alpha ,A) - delta * k_star_old
c_star_new <- f(k_star_new , alpha ,A_new) - delta * k_star_new

hc <- function(k, c) {c * {beta * (alpha* A_new * {A_new * k^alpha + (1 - delta) * k - c}^(alpha - 1) + (1 - delta))}^(1 / theta)}
hk <- function(k, c) {A_new * k^alpha + (1 - delta) * k - c}

k <- quote(k)
c <- quote(c)

hck <- Deriv(hc, "k")
hcc <- Deriv(hc, "c")
hkk <- Deriv(hk, "k")
hkc <- Deriv(hk, "c")

M <- matrix(c(hkk(k_star_new,c_star_new), hkc(k_star_new,c_star_new), hck(k_star_new,c_star_new), hcc(k_star_new,c_star_new)), nrow = 2, byrow = TRUE)
eigen(M)
eigen(M)$values[2]
v_12 <-  eigen(M)$vectors[1,2]
v_22 <-  eigen(M)$vectors[2,2]


k0_hat <- k_star_old- k_star_new 
z1_0 <- k0_hat/v_12
c0_hat <- z1_0*v_22

t= 0:30
results <- sapply(t, function(t) eigen(M)$values[2]^t * c(k0_hat,c0_hat))
results_df <- data.frame(t, k_t = results[1,] + k_star_new, c_t = results[2,] + c_star_new)

ggplot(results_df, aes(x = t)) +
  geom_line(aes(y = k_t, color = "K_t")) +  # K_t 曲線
  geom_line(aes(y = c_t, color = "C_t")) +  # C_t 曲線
  labs(title = "C_t and K_t vs Time (t)", x = "Time (t)", y = "Values") +
  scale_color_manual("", 
                     breaks = c("K_t", "C_t"),
                     values = c("K_t" = "blue", "C_t" = "red")) +
  theme_minimal()

ggplot(results_df, aes(x = k_t, y = c_t, group = 1, color = factor(t))) +  # group = 1 connects all points
  geom_line() +  # Use geom_line() to connect the points with lines
  geom_point() + # Add points to highlight each data point
  labs(title = "Dynamics of Capital and Consumption Over Time",
       x = "Capital (k_t)",
       y = "Consumption (c_t)",
       color = "Time") +
  theme_minimal() +
  scale_color_viridis_d() 

