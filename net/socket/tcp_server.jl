using Sockets


function main()
    port = 8080
    # listen用ソケットを取得
    server = listen(port)
    println("start server")
    try
        while true
            socket = accept(server)
            println("accepted")
            Threads.@spawn run(socket)
        end
    catch e
        println(e)
    finally
        isopen(server) && close(server)
        println("close server")
    end
end

"""
各スレッドで実行
"""
function run(socket::TCPSocket)
    try
        line = readline(socket)
        @info "$(Threads.threadid()): $(line)"
        println(socket, line)
    catch e
        println(e)
    finally
        isopen(socket) && close(socket)
        println("socket close")
    end
end