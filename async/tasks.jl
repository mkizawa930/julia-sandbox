
function hello(id=0)
    println("@$(threadid())")
    # time = rand(1:5)
    time = 0
    sleep(time)
    return id, time
end

function main()
    tasks = Task[]
    for i in 1:5
        task = @spawn hello(i)
        push!(tasks, task)
    end

    @sync for task in tasks
        @async begin 
            id, result = fetch(task)
            println("got from $id, result=$result")
        end
    end
end