# StrFormat

| **Info** | **Package Status** | **Package Evaluator** | **Coverage** |
|:------------------:|:------------------:|:---------------------:|:-----------------:|
| [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE.md) | [![Build Status](https://travis-ci.org/JuliaString/StrFormat.jl.svg?branch=master)](https://travis-ci.org/JuliaString/StrFormat.jl) | [![StrFormat](http://pkg.julialang.org/badges/StrFormat_0.6.svg)](http://pkg.julialang.org/?pkg=StrFormat) | [![Coverage Status](https://coveralls.io/repos/github/JuliaString/StrFormat.jl/badge.svg?branch=master)](https://coveralls.io/github/JuliaString/StrFormat.jl?branch=master)
| [![Gitter Chat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/JuliaString/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge) | | [![StrFormat](http://pkg.julialang.org/badges/StrFormat_0.7.svg)](http://pkg.julialang.org/?pkg=StrFormat) | [![codecov.io](http://codecov.io/github/JuliaString/StrFormat.jl/coverage.svg?branch=master)](http://codecov.io/github/JuliaString/StrFormat.jl?branch=master)

StrFormat extends the string literals provided by the [StrLiterals](https://github.com/JuliaString/StrLiterals.jl) package.
It uses an extensively modified fork of the [Formatting](https://github.com/JuliaIO/Formatting.jl) package to provide formatting capability, as well as Tom Breloff's [PR #10](https://github.com/JuliaIO/Formatting.jl/pull/10), which provides the capability of using settable printing defaults based on the types of the argument (see [Format](https://github.com/JuliaString/Format.jl).

The following extra format sequences (see [StrLiterals](https://github.com/JuliaString/StrLiterals.jl) for the full specification) are added:

* `\%<ccc><formatcode>(arguments)` is interpolated as a call to `cfmt("<cccc><formatcode>",arguments)`, where `<ccc><formatcode>` is a C-style format string.

* `\%(arguments)` is interpolated as a call to `fmt(arguments)`.
This is especially useful when defaults have been set for the type of the first argument.

* `fmt_default!{T}(::Type{T}, syms::Symbol...; kwargs...)` sets the defaults for a particular type.
* `fmt_default!(syms::Symbol...; kwargs...)` sets the defaults for all types.

Symbols that can currently be used are: `:ljust` or `:left`, `:rjust` or `:right`, `:commas`, `:zpad` or `:zeropad`, and `:ipre` or `:prefix`.
* `reset!{T}(::Type{T})` resets the defaults for a particular type.
* `defaultSpec(x)` will return the defaults for the type of x, and
* `defaultSpec{T}(::Type{T})` will return the defaults for the given type.

There is currently support for Python style formatting, although that is a work-in-progress,
and I am intending to improve the syntax to make it as close as possible to Python's 3.6 format strings.
Currently, the syntax is `\{<formatstring>}(expression)`, however I plan on changing it shortly to `\{expression}` (equivalent to `pyfmt("", expression)`, and `\{expression;formatstring}` (equivalent to `pyfmt("formatstring", expression)`.
