using DelimitedFiles
using Flux: train!
using Flux

function read_sim_data(dir)
    ρ_profiles = Vector{Vector{Float64}}()
    c1_profiles = Vector{Vector{Float64}}()
    for sim in readdir(dir, join=true)
        sim_data = readdlm(sim)
        push!(ρ_profiles, sim_data[:, 1])
        push!(c1_profiles, sim_data[:, 2])
    end
    ρ_profiles, c1_profiles
end

function generate_inout(ρ_profiles, c1_profiles; window_bins=201)
    ρ_windows = Vector{Vector{Float64}}()
    c1_values = Vector{Float64}()
    pad = window_bins ÷ 2 - 1
    for (ρ, c1) in zip(ρ_profiles, c1_profiles)
        ρpad = vcat(ρ[end-pad:end], ρ, ρ[begin:begin+pad])
        for i in 1:length(c1)
            push!(ρ_windows, ρpad[i:i+window_bins])
            push!(c1_values, c1[i])
        end
    end
    hcat(ρ_windows...), c1_values
end

model = Chain(
    Dense(200 => 256, softplus),
    Dense(256 => 256, softplus),
    Dense(256 => 1),
)

optim = Flux.setup(Flux.Optimiser(Adam(0.001), ExpDecay(1.0, 0.05, 1, 1e-8, 5)), model)

ρ_profiles, c1_profiles = read_sim_data("data")
ρ_windows, c1_values = generate_inout(ρ_profiles, c1_profiles)
loader = Flux.DataLoader((ρ_windows, c1_values), batchsize=128, shuffle=true)

losses = []
for epoch in 1:100
    for (ρ_window, c1) in loader
        loss, grads = Flux.withgradient(model) do m
            c1_prediction = m(ρ_window)
            Flux.mse(c1_prediction, c1)
        end
        Flux.update!(optim, model, grads[1])
        push!(losses, loss)
    end
end
