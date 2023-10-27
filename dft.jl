using FFTW

function conv_fft(f::Vector, g::Vector; dx::Number=0.01)
    irfft(rfft(f) .* rfft(g), length(f)) * dx
end

function get_weights_Percus(xs)
    xs .-= xs[begin] # undo shift of dx/2
    dx = xs[2]
    L = xs[end] + dx
    R = 0.5
    @assert L >= 2*R "To construct the Percus weight functions, the system must have a length of at least 2R."
    @assert count(xs .≈ R) == 1 "The grid is not suitable for the construction of the Percus weight functions. R must be a multiple of dx."
    ω0 = zero(xs)
    ω0[xs.≈R] .= 0.5 / dx
    ω0[2:end] += reverse(ω0[2:end])
    ω1 = zero(xs)
    ω1[xs.<R] .= 1
    ω1[xs.≈R] .= 0.5
    ω1[2:end] += reverse(ω1[2:end])
    ω0, ω1
end