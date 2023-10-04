include("simulation.jl")

using Plots


L = 10.0
μ = 3.0
Vext(x) = x < 1.0 || x > L - 1.0 ? Inf : 0
ϕ(r) = r < 1.0 ? Inf : 0

result = simulate(L, μ, Vext, ϕ; equilibrate_steps=100000, production_steps=1000000, sweep=10)

p = plot(result[:x], result[:ρ])
display(p)
