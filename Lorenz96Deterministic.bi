/**
 * Lorenz '96 deterministic model for bifurcation plots.
 */
model Lorenz96Deterministic {
  dim n(size = 8, boundary = 'cyclic')

  const h = 0.05   // step size

  param F          // forcing
  state x[n]       // state variables

  sub parameter {
    F ~ uniform(0.0, 12.0)
  }

  sub initial {
    x[n] ~ uniform(1 - F, 1 + F)
  }

  sub transition(delta = h) {
    ode(h = h, alg = 'RK4') {
      dx[n]/dt = x[n-1]*(x[n+1] - x[n-2]) - x[n] + F
    }
  }
}
