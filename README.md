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

# C style formatting specification language

* `\%<ccc><formatcode>(arguments)` is interpolated as a call to `cfmt("%<ccc><formatcode>",arguments)`, where `<ccc><formatcode>` is a C-style format string.
* and <ccc> is [flags][width][.precision][length]

* supported flags are: ` `, `-`, `+`, `0`, `#`, and `'` (add comma thousand separators)
* formatcode := `d` | `D` | `u` | `U` | `o` | `O` | `x` | `X` | `e` | `E` | `f` | `F` | `g` | `G` | `a` | `A` | `c` | `C` | `s` | `S` | `i` | `p` | `n`
* length is ignored (it was only needed for C/C++ since argument values don't have types)

# Type based formatting

* `\%(value, arguments...)` is interpolated as a call to `fmt(value, arguments...)`.
This is especially useful when defaults have been set for the type of the first argument.

* `fmt_default!{T}(::Type{T}, syms::Symbol...; kwargs...)` sets the defaults for a particular type.
* `fmt_default!(syms::Symbol...; kwargs...)` sets the defaults for all types.
* `reset!{T}(::Type{T})` resets the defaults for a particular type.
* `defaultSpec(x)` will return the defaults for the type of x, and
* `defaultSpec{T}(::Type{T})` will return the defaults for the given type.

Symbols that can currently be used are: `:ljust` or `:left`, `:rjust` or `:right`, `:center`, `:commas`, `:zpad` or `:zeropad`, and `:ipre` or `:prefix`.
Several keyword arguments can also be used:
Keyword | Type | Meaning                   | Default
--------|------|---------------------------|-------
fill    | Char | Fill character            | ' '
align   | Char | Alignment character       | '\\0'
sign    | Char | Sign character            | '-'
width   | Int  | Field width               | -1, i.e. ignored
prec    | Int  | Floating Precision        | -1, i.e. ignored
ipre    | Bool | Use 0b, 0o, or 0x prefix? | false
zpad    | Bool | Pad with 0s on left       | false
tsep    | Bool | Use thousands separator?  | false

# Python style formatting specification language
(supports most all options except for '%' currently)

  * spec  ::= [[fill]align][sign][#][0][width][,_][.prec][type]
  * fill  ::= <any character>
  * align ::= '<' | '^' | '>'
  * sign  ::= '+' | '-' | ' '
  * width ::= <integer>
  * prec  ::= <integer>
  * type  ::= 'b' | 'c' | 'd' | 'e' | 'E' | 'f' | 'F' | 'g' | 'G' | 'n' | 'o' | 'x' | 'X' | 's'

Please refer to http://docs.python.org/2/library/string.html#formatspec
for more details

The syntax is slightly different, `\{<formatspec>}(expression)`, instead of `{variable:formatspec}`, so as to fit better with Julia's string syntax.
