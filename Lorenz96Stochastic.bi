/**
 * Lorenz '96 stochastic model for bifurcation plots.
 */
model Lorenz96Stochastic {
  dim n(size = 8, boundary = 'cyclic')

  const h = 0.05   // step size

  param F          // forcing
  param sigma2     // diffusion variance
  state x[n]       // state variables
  noise deltaW[n]  // Wiener process increments

  sub parameter {
    F ~ uniform(0.0, 12.0)
    sigma2 ~ inverse_gamma(2.0, 0.9)
  }

  sub initial {
    x[n] ~ uniform(-1.0, 3.0)
  }

  sub transition(delta = h) {
    deltaW[n] ~ wiener()
    ode(h = h, alg = 'RK4') {
      dx[n]/dt = x[n-1]*(x[n+1] - x[n-2]) - x[n] + F + sqrt(sigma2)*deltaW[n]/h
    }
  }
}
