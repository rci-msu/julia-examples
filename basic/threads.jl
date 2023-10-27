using Statistics
using BenchmarkTools
using LinearAlgebra

function sim(a::Int)
    k = 0
    Threads.@threads for i in 1:a
        m = rand(1:10)
        m = m * rand()
        t = m^2
        if t > 10
            k = k + 1
        end
    end
    r = k / a
    return r
end

function run_sim(n::Int, m::Int)
    k = Float64[]
    for i in 1:n
      push!(k,sim(m))
    end
    println(m*n, " sims")
    println(mean(k))
end


function compute_determinants(n_matrices::Int, matrix_size::Int)
    
    determinants = zeros(1,n_matrices)

    Threads.@threads for i in 1:n_matrices
        println("hello from thread $(Threads.threadid())")
        determinants[i] = det(rand(matrix_size, matrix_size))
    end
    return sum(determinants)
end

#@showtime compute_determinants(100, 1000)

x = 1_000_000
y = 1024
@showtime run_sim(x, y)
println(Threads.nthreads())
