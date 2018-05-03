__precompile__(true)
""""
Add C, Python and type-based formatting to Str string literals

Copyright 2016-2018 Gandalf Software, Inc., Scott P. Jones
Licensed under MIT License, see LICENSE.md
"""
module StrFormat

using Format, StrLiterals

parse_error(s) = throw(StrLiterals._ParseError(s))

_check_exp(ex) =
    isa(ex, Expr) && (ex.head === :continue) && parse_error("Incomplete expression")

function _parse_format(str, pos, fun)
    ex, j = StrLiterals._parse(str, pos; greedy=false)
    _check_exp(ex)
    ex, k = StrLiterals._parse(string("a", str[pos:j-1]), 1, greedy=true)
    _check_exp(ex)
    isa(ex, Symbol) && (println(string("a", str[pos:j-1])) ; dump(ex))
    ex.args[1] = fun
    ex, j
end

function _parse_fmt(sx::Vector{Any}, s::AbstractString, unescape::Function,
                    i::Integer, j::Integer, k::Integer)
    # Move past \\, k should point to '%'
    c, k = next(s, k)
    done(s, k) && parse_error("Incomplete % expression")
    # Handle interpolation
    isempty(s[i:j-1]) || push!(sx, unescape(s[i:j-1]))
    if s[k] == '('
        # Need to find end to parse to
        ex, j = _parse_format(s, k, Format.fmt)
    else
        # Move past %, c should point to letter
        beg = k
        while true
            c, k = next(s, k)
            done(s, k) && parse_error("Incomplete % expression")
            s[k] == '(' && break
        end
        ex, j = _parse_format(s, k, Format.cfmt)
        insert!(ex.args, 2, s[beg-1:k-1])
    end
    push!(sx, esc(ex))
    j
end

function _parse_pyfmt(sx::Vector{Any}, s::AbstractString, unescape::Function,
                      i::Integer, j::Integer, k::Integer)
    # Move past \\, k should point to '{'
    c, k = next(s, k)
    done(s, k) && parse_error("Incomplete {...} Python format expression")
    # Handle interpolation
    isempty(s[i:j-1]) || push!(sx, unescape(s[i:j-1]))
    beg = k # start location
    c, k = next(s, k)
    while c != '}'
        done(s, k) && parse_error(string("\\{ missing closing } in ", c))
        c, k = next(s, k)
    end
    done(s, k) && parse_error("Missing (expr) in Python format expression")
    c, k = next(s, k)
    c == '(' || parse_error(string("Missing (expr) in Python format expression: ", c))
    # Need to find end to parse to
    ex, j = _parse_format(s, k-1, Format.pyfmt)
    insert!(ex.args, 2, s[beg:k-3])
    push!(sx, esc(ex))
    j
end

function __init__()
    StrLiterals.interpolate['%'] = _parse_fmt
    StrLiterals.interpolate['{'] = _parse_pyfmt
end

end # module StrFormat
