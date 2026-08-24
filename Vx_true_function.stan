functions {
  real Vxfun(real x) {
    return 0.2 * x + pow(x, 5);
  }
}

data {
  int<lower=1> N;  // data used for inference
  vector[N] x;
  vector[N] y;
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
    mu[n] = Vxfun(z);
  }
}

model {
  a ~ normal(0,1);
  b ~ normal(0,1);
  sigma ~ gamma(2,20);
  y ~ normal(mu, sigma);
}
