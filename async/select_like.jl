


cond = Condition()

function watch(channels, cond)
    while true
        any(isready.(channels)) && notify(cond)
        sleep(0)
    end
end

function select(channels)
    while any(isready.(channels))
        chan = @views rand(channels[isready.(channels)])
        id = take!(chan)
        println("id: $id")
    end
end

function wait_put(ch, id, cond)
    while true
        sec = rand(1:3)
        sleep(sec)
        # notify(cond)
        put!(ch, id)
    end
end

function main()
    cond = Condition()
    ch1 = Channel()
    ch2 = Channel()
    ch3 = Channel()
    channels = [ch1, ch2, ch3]
    @async watch(channels, cond)
    for i in 1:3
        @async wait_put(ch1, i, nothing)
    end
    try
        while true
            wait(cond)
            println("notified")
            select(channels)
        end
    catch e
        println(e)
    end
end
