module RandomSplit

export PRNGKey, splitkey

import Random
using Random: AbstractRNG, Sampler, SamplerType, SamplerUnion

# DEFAULT_RNG = Random.typeof_rng(Random.GLOBAL_RNG)
DEFAULT_RNG = Random.MersenneTwister

struct PRNGKey{T} <: AbstractRNG
    seed :: UInt32
#    PRNGKey(seed::Integer) = new{Xoshiro}(seed)
#    PRNGKey{T}(seed::Integer) where T = new{T}(seed)
end

PRNGKey{T}() where T = PRNGKey{T}(rand(UInt32))
PRNGKey() = PRNGKey{DEFAULT_RNG}()
PRNGKey(seed::Integer) = PRNGKey{DEFAULT_RNG}(seed)

Random.rng_native_52(::PRNGKey{T}) where {T} = UInt64

copy(rng::PRNGKey{T}) where {T} = typeof(rng)(rng.seed)

function Base.rand(rng::PRNGKey{T},
    S::SamplerUnion(Bool, Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64)) where {T}
    return rand(T(rng.seed), S)
end

function Base.rand(rng::PRNGKey{T}, S::SamplerType{UInt64}) where {T}
    return rand(T(rng.seed), S)
end

function Random.rand!(rng::PRNGKey, A::AbstractArray{T}, sp::Sampler) where {T}
    rng_ = rng
    for i in eachindex(A)
        rng_ = typeof(rng)(rand(rng_, UInt32))
        @inbounds A[i] = rand(rng_, sp)
    end
    A
end

function splitkey(k::PRNGKey{T}, n::Integer=2) where {T}
    seeds = rand(k, UInt32, n)
    return [typeof(k)(s) for s in seeds]
end


end
