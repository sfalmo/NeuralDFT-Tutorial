struct System
    L::Float64
    μ::Float64
    β::Float64
    Vext::Function
    ϕ::Function
    particles::Vector{Float64}
    System(L::Number, μ::Number, T::Number, Vext::Function, ϕ::Function) = new(L, μ, 1 / T, Vext, ϕ, [])
end

mutable struct Histograms
    bins::Int
    dx::Float64
    ρ::Vector{Float64}
    count::Int
    function Histograms(system::System; bins=1000)
        new(bins, system.L / bins, zeros(bins), 0)
    end
end

function pbc!(system::System, i)
    system.particles[i] -= floor(system.particles[i] / system.L) * system.L
end

function dist(xi, xj, L)
    result = xj - xi
    result -= round(result / L) * L
    abs(result)
end

function add_particle!(system::System, x)
    push!(system.particles, x)
end

function remove_particle!(system::System, i)
    deleteat!(system.particles, i)
end

function calc_particle_interaction(system::System, i)
    xi = system.particles[i]
    E = system.Vext(xi)
    for xj in system.particles
        if xi == xj
            continue
        end
        E += system.ϕ(dist(xi, xj, system.L))
    end
    E
end

function trial_insert(system::System)
    add_particle!(system, rand() * system.L)
    i = length(system.particles)
    ΔE = calc_particle_interaction(system, i)
    if rand() > system.L / length(system.particles) * exp(system.β * (system.μ - ΔE))
        # Rejected, undo trial insert
        remove_particle!(system, i)
    end
end

function trial_delete(system::System)
    if isempty(system.particles)
        return
    end
    i = rand(1:length(system.particles))
    ΔE = calc_particle_interaction(system, i)
    if rand() < length(system.particles) / system.L * exp(system.β * (ΔE - system.μ))
        # Accepted, do the actual removal
        remove_particle!(system, i)
    end
end

function get_results(system::System, histograms::Histograms)
    dx = histograms.dx
    collect(dx/2:dx:system.L-dx/2), histograms.ρ / (histograms.count * dx)
end
