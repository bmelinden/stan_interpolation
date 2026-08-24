# stan_interpolation

A draft implementation of PCHIP (Piecewise Cubic Hermite Interpolating Polynomial) and natural cubic spline interpolation in Stan, for using look-up tables in Stan models. The target use case is to define arbitrary functions from discrete data in Stan models, for example to incorporate empirical material properties or other user-defined smooth functions.

PCHIP interpolates using piece-wise 3rd order Hermite polynomials constructed to have continuous first derivatives and to preserve monotonicity and shape. This is a common method, also available in for example [pracma](https://www.rdocumentation.org/packages/pracma/versions/1.9.9/topics/pchip), [Matlab](https://se.mathworks.com/help/matlab/ref/pchip.html) and [Boost](https://www.boost.org/doc/libs/latest/libs/math/doc/html/math_toolkit/pchip.html), and [scipy](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.PchipInterpolator.html). The present implementation was generated with the help of AI, and the included test script makes a comprison with the pracma pchip function and achieves acceptable agreement.

Natural cubic splines also use piece-wise 3rd order polynomials, but are constructed to have continuous second derivatives while not preserving monotonicity. This can be suitable for approximating smooth functions, and various spline interpolations are also included in most numerical tool kits. The stan implementation is tested against the R stats package ([splinefun](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/splinefun)).

Both interpolation methods are implemented with a two-step usage pattern, first  setup() cal to pre-compute polynomial coefficients, then an eval() function to compute interpolated values.

## R files

- pchip_math_test.R : test of pchip interpolation against pracma::pchip
- spline_math_test.R : test of spline interpolation against stats::spline
- lookup_model_example.qmd : A simple Stan model involving a non-linear transformation to demonstrate the use of look-up tables.

## Stan files
- spline.stanfunctions, pchip.stanfunctions : spline/pchip interpolation functions to include in stan function blocks.
- spline_math_test.stan, pchip_math_test.stan : stan models that only interpolate in supplied lookup tables using the respective interpolation method; for testing purposes
