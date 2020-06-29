# StrFormat

[pkg-url]: https://github.com/JuliaString/StrFormat.jl.git

[julia-url]:    https://github.com/JuliaLang/Julia
[julia-release]:https://img.shields.io/github/release/JuliaLang/julia.svg

[release]:      https://img.shields.io/github/release/JuliaString/StrFormat.jl.svg
[release-date]: https://img.shields.io/github/release-date/JuliaString/StrFormat.jl.svg

[license-img]:  http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat
[license-url]:  LICENSE.md

[gitter-img]:   https://badges.gitter.im/Join%20Chat.svg
[gitter-url]:   https://gitter.im/JuliaString/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge

[travis-url]:   https://travis-ci.org/JuliaString/StrFormat.jl
[travis-s-img]: https://travis-ci.org/JuliaString/StrFormat.jl.svg
[travis-m-img]: https://travis-ci.org/JuliaString/StrFormat.jl.svg?branch=master

[codecov-url]:  https://codecov.io/gh/JuliaString/StrFormat.jl
[codecov-img]:  https://codecov.io/gh/JuliaString/StrFormat.jl/branch/master/graph/badge.svg

[contrib]:    https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat

[![][release]][pkg-url] [![][release-date]][pkg-url] [![][license-img]][license-url] [![contributions welcome][contrib]](https://github.com/JuliaString/StrFormat.jl/issues)

| **Julia Version** | **Unit Tests** | **Coverage** |
|:------------------:|:------------------:|:---------------------:|
| [![][julia-release]][julia-url] | [![][travis-s-img]][travis-url] | [![][codecov-img]][codecov-url]
| Julia Latest | [![][travis-m-img]][travis-url] | [![][codecov-img]][codecov-url]

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
