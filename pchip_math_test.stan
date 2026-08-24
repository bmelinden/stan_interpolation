functions {
  #include pchip.stanfunctions
}
data {
  int<lower=2> K;
  vector[K] xk; // Lookup-table x values; must be strictly increasing.
  vector[K] yk; // Lookup-table y values.
  int<lower=1> N_eval;
  vector[N_eval] x_eval;
}
transformed data {
  tuple(matrix[K - 1, 4], vector[K]) W = pchip_setup(xk, yk);
}
generated quantities {
  vector[K] pchip_slope = pchip_slopes(xk, yk);
  matrix[K - 1, 4] pchip_coef = W.1;
  vector[N_eval] y_eval;
  
  for (n in 1 : N_eval) {
    y_eval[n] = pchip_eval(x_eval[n], W);
  }
}
