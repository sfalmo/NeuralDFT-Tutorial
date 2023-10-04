using LinearAlgebra
using FFTW

function conv_fft(f::Vector, g::Vector, dx::Number; rfftP=plan_rfft(f))
    rfftP \ ((rfftP * f) .* (rfftP * g)) * dx
end

function get_weights_Percus(xs)
    xs .-= xs[begin] # undo shift of dx/2
    dx = xs[2]
    L = xs[end] + dx
    R = 0.5
    ω0 = zero(xs)
    ω0[xs.≈R.||xs.≈L-R] .= 1 / dx
    ω1 = zero(xs)
    ω1[xs.<R.||xs.>L-R] .= 1
    ω1[xs.≈R.||xs.≈L-R] .= 0.5
    ω0, ω1
end

function get_c1_Percus(xs)
    ω0, ω1 = get_weights_Percus(xs)
    n0, n1 = zero(xs), zero(xs)
    ϕ0, ϕ1 = zero(xs), zero(xs)
    conv = (f, g) -> conv_fft(f, g, xs[2] - xs[1], rfftP=plan_rfft(xs))
    c1 = zero(xs)
    function (ρ)
        c1 .= 0
        n0 .= conv(ρ, ω0)
        n1 .= conv(ρ, ω1)
        ϕ0 .= -log.(1 .- n1)
        ϕ1 .= n0 ./ (1 .- n1)
        c1 .-= conv(ϕ0, ω0)
        c1 .-= conv(ϕ1, ω1)
        c1
    end
end

function minimize(L::Number, μ::Number, Vext::Function, functional::String="Percus"; α::Number=0.05, tol::Number=1e-8, maxiter::Int=10000)
    dx = 0.01
    xs = collect(dx/2:dx:L)
    Vext = Vext.(xs)
    infiniteVext = isinf.(Vext)
    ρ, ρEL = zero(xs), zero(xs)
    fill!(ρ, 0.5)
    if functional == "Percus"
        c1 = get_c1_Percus(xs)
    else
        println("Functional $(functional) not implemented")
        return nothing
    end
    i = 0
    while true
        ρEL .= exp.(μ .- Vext .+ c1(ρ))
        ρ .= (1 - α) .* ρ .+ α .* ρEL
        ρ[infiniteVext] .= 0
        clamp!(ρ, 0, Inf)
        Δρmax = norm((ρ - ρEL)[.!infiniteVext], Inf)
        i += 1
        if Δρmax < tol
            break
        end
        if !isfinite(Δρmax) || i >= maxiter
            println("Did not converge (step: $(i), ‖Δρ‖: $(Δρmax))")
            return nothing
        end
    end
    Dict(:x => xs, :ρ => ρ)
end
