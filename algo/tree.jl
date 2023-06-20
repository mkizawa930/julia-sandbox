
Optional{T} = Union{Nothing, T}

struct Node{V,T}
    value::V
    left::Optional{T}
    right::Optional{T}
end

