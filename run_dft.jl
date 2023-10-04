include("dft.jl")

using Plots


L = 10
μ = 3.0
Vext(x) = x < 1.0 || x > L - 1.0 ? Inf : 0
functional = "Percus"

result = minimize(L, μ, Vext, functional)

p = plot(result[:x], result[:ρ])
display(p)
