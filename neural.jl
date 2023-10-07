using DelimitedFiles
using Flux: train!
using Flux

function read_sim_data(dir)
    ρ_profiles = Vector{Vector{Float64}}()
    c1_profiles = Vector{Vector{Float64}}()
    for sim in readdir(dir, join=true)
        sim_data = readdlm(sim)
        xs, μloc, ρ = sim_data[:, 1], sim_data[:, 2], sim_data[:, 3]
        c1 = log.(ρ) .- μloc
        push!(ρ_profiles, ρ)
        push!(c1_profiles, c1)
    end
    ρ_profiles, c1_profiles
end

function generate_windows(ρ; window_bins=201)
    ρ_windows = zeros(window_bins, length(ρ))
    pad = window_bins ÷ 2 - 1
    ρpad = vcat(ρ[end-pad:end], ρ, ρ[begin:begin+pad])
    for i in 1:length(ρ)
        ρ_windows[:,i] = ρpad[i:i+window_bins-1]
    end
    ρ_windows
end

function generate_inout(ρ_profiles, c1_profiles; window_bins=201)
    ρ_windows_all = Vector{Vector{Float64}}()
    c1_values_all = Vector{Float64}()
    for (ρ, c1) in zip(ρ_profiles, c1_profiles)
        ρ_windows = generate_windows(ρ; window_bins)
        for i in 1:length(c1)
            if isnan(c1[i])
                continue
            end
            push!(ρ_windows_all, ρ_windows[:,i])
            push!(c1_values_all, c1[i])
        end
    end
    Float32.(hcat(ρ_windows_all...)), Float32.(c1_values_all')
end
