# RandomSplit

[![Build Status](https://github.com/olivierverdier/RandomSplit.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/olivierverdier/RandomSplit.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![codecov](https://codecov.io/gh/olivierverdier/RandomSplit.jl/graph/badge.svg?token=MPU338SC4J)](https://codecov.io/gh/olivierverdier/RandomSplit.jl)

Emulates the behaviour of [JAXs pseudorandom number generators keys](https://jax.readthedocs.io/en/latest/jax.random.html).

This works roughly like this
```julia
using RandomSplit
key = PRNGKey(0)
k, k_ = splitkey(k)
rand(k, Int) # some random Int
rand(k, Int) # SAME integer
```

In other words, you *must* split the key explicitly in order to obtain random results.

**This package is hardly tested, use at your own risk.**

(Contributions welcome, though)
