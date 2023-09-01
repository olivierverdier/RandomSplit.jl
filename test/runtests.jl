using RandomSplit
using Test

using Random

@testset "RandomSplitkey.jl" begin
    kk = PRNGKey(0)
    k = PRNGKey{MersenneTwister}()

    k, k_ = splitkey(k)

    rand(k, Int, 2)

    k_ = k

    k, k_ = splitkey(k_)

    rand(k)

    rand(k, Float64, 3)

    k1, k2 = splitkey(k)

    k = PRNGKey()

    splitkey(k, 3)

end
