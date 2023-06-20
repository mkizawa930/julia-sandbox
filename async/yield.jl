function task1()
    println("Starting task 1")
    for i in 1:5
        sleep(rand())
        println("Task 1: $i")
        yield()
    end
    println("Task 1 completed")
end

function task2()
    println("Starting task 2")
    for i in 1:5
        sleep(rand())
        println("Task 2: $i")
        yield()
    end
    println("Task 2 completed")
end

function main()
    @sync begin
        # Create two tasks and run them concurrently
        t1 = @async task1()
        t2 = @async task2()

        # Wait for both tasks to complete
        #wait()
    end
end

main()
