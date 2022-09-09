module Model

using Dates

mutable struct Todo
  title::String
  done::Bool
  created_at::Dates.DateTime
end



end # module
