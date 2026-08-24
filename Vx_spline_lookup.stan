functions {
  #include spline.stanfunctions
}

data {
  int<lower=1> N;  // data used for inference
  vector[N] x;
  vector[N] y;
  int<lower=2> K;  // data used to parameterise the lookup table
  vector[K] xk;
  vector[K] Vk;
}

transformed data {
  tuple(matrix[K - 1, 4], vector[K]) W = spline_setup(xk, Vk);
}

parameters {
  real a;
  real b;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  for (n in 1:N) {
    real z = a + b * x[n];
    mu[n] = spline_eval(z, W);
  }
}

model {
  a ~ normal(0,1);
  b ~ normal(0,1);
  sigma ~ gamma(2,20);
  y ~ normal(mu, sigma);
}
