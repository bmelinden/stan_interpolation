functions {
  #include spline.stanfunctions
}
data {
  int<lower=2> K;
  vector[K] xk; // Lookup-table x values; must be strictly increasing.
  vector[K] yk; // Lookup-table y values.
  int<lower=1> N_eval;
  vector[N_eval] x_eval;
}
transformed data {
  tuple(matrix[K - 1, 4], vector[K]) W = spline_setup(xk, yk);
}
generated quantities {
  vector[K] spline_second_deriv = spline_second_derivatives(xk, yk);
  matrix[K - 1, 4] spline_coef = W.1;
  vector[N_eval] y_eval;
  
  for (n in 1 : N_eval) {
    y_eval[n] = spline_eval(x_eval[n], W);
  }
}
