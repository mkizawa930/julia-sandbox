
mutable struct Node{T}
    value::Union{Nothing,T}
    left::Union{Nothing,Node{T}}
    right::Union{Nothing,Node{T}}
end
Node{T}() where T = Node{T}(nothing, nothing, nothing)
Node(value::T) where T = Node{T}(value, Node{T}(), Node{T}())

haschild(node) = node.left !== nothing

function heapify(node::Node{T}, a::AbstractArray{T}, k) where T
    k *= 2
    k > length(a) && return
    node.left = Node(a[k])
    k+1 > length(a) && return
    node.right = Node(a[k+1])
    heapify(node.left, a, k)
    heapify(node.right, a, k+1)
end


function heapsort(a)
    a = copy(a)
    for i = length(a):-1:2
        a = heapify(a, i)
    end
    
    return a
end

function heapify(a, k)
    i = k
    while i > 1
        j = i >> 1
        if a[j] < a[i] 
            # parent < child -> swap
            a[i], a[j] = a[j], a[i]
            is_swapped = true
        end
        i = i - 1
    end
    a[1], a[k] = a[k], a[1]
    a
end


"""

1. 左側を並べ替え済みとし、順に並べ替えていく

"""
function insertion_sort(a)
    a = copy(a)
    length(a) == 1 && return a
    i = 2
    while true
        i > length(a) && break
        for j = i:-1:2
            a[j-1] <= a[j] && break
            # swap
            a[j], a[j-1] = a[j-1], a[j]
        end
        i += 1
    end
    a
end


