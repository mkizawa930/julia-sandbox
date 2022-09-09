module TodoRepository

include("./Model.jl")
using .Model: Todo

function create(todo::Todo)
end

function findall(::Type{Todo})::Vector{Todo}
end

function update(todo::Todo)
end

function delete(todo::Todo)
end

end # module
