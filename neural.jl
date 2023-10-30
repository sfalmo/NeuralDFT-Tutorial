import Flux.Zygote

function read_sim_data(dir)
    ρ_profiles = Vector{Vector{Float64}}()
    c1_profiles = Vector{Vector{Float64}}()
    for sim in readdir(dir, join=true)
        xs, μloc, ρ = eachcol(readdlm(sim))
        c1 = log.(ρ) .- μloc
        push!(ρ_profiles, ρ)
        push!(c1_profiles, c1)
    end
    ρ_profiles, c1_profiles
end

function generate_windows(ρ; window_bins)
    ρ_windows = Zygote.Buffer(zeros(Float32, window_bins, length(ρ)))  # We use a Zygote Buffer here to keep autodifferentiability
    pad = window_bins ÷ 2 - 1
    ρpad = vcat(ρ[end-pad:end], ρ, ρ[1:1+pad])
    for i in 1:length(ρ)
        ρ_windows[:,i] = ρpad[i:i+window_bins-1]
    end
    copy(ρ_windows)  # copy needed due to Zygote.Buffer
end

function generate_inout(ρ_profiles, c1_profiles; window_width, dx)
    window_bins = 2 * round(Int, window_width / dx) + 1
    ρ_windows_all = Vector{Vector{Float32}}()
    c1_values_all = Vector{Float32}()
    for (ρ, c1) in zip(ρ_profiles, c1_profiles)
        ρ_windows = generate_windows(ρ; window_bins)
        for i in 1:length(c1)
            if !isfinite(c1[i])
                continue
            end
            push!(ρ_windows_all, ρ_windows[:,i])
            push!(c1_values_all, c1[i])
            push!(ρ_windows_all, reverse(ρ_windows[:,i]))
            push!(c1_values_all, c1[i])
        end
    end
    reduce(hcat, ρ_windows_all), c1_values_all'
end

function finite_diff(a; dx)
    dv = diff(a) / 2
    v = [dv[1]; dv]
    v .+= [dv; dv[end]]
    v / dx
end