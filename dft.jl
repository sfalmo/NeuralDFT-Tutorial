using FFTW

function conv_fft(f::Vector, g::Vector; dx::Number=0.01, rfftP=plan_rfft(f))
    rfftP \ ((rfftP * f) .* (rfftP * g)) * dx
end

function get_weights_Percus(xs)
    xs .-= xs[begin] # undo shift of dx/2
    dx = xs[2]
    L = xs[end] + dx
    R = 0.5
    ω0 = zero(xs)
    @assert count(xs .≈ R .|| xs .≈ L - R) == 2 "The grid is not suitable for the construction of the Percus weight functions. R must be a multiple of dx."
    ω0[xs.≈R.||xs.≈L-R] .= 0.5 / dx
    ω1 = zero(xs)
    ω1[xs.<R.||xs.>L-R] .= 1
    ω1[xs.≈R.||xs.≈L-R] .= 0.5
    ω0, ω1
end
