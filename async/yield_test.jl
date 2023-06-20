
function worker(ch, id)
    for i in 1:30
        sleep(rand())
        put!(ch, (id, i))
        yield()
    end
end

function watcher(channels, cond)
    while true
        for ch in channels
            if isready(ch)
                notify(cond)
                break
            end
        end
        yield()
    end
end

begin
    ch1 = Channel()
    ch2 = Channel()
    channels = [ch1, ch2]
    for (ch, i) in enumerate(channels)
        @async worker(ch, i)
    end
    cond = Condition()
    @async watcher(channels, cond)
    while true
        wait(cond)
        for ch in channels
            if isready(ch)
                take!(ch) |> println
                break
            end
        end
    end
end
