"""
複数のチャンネルを待機状態にして
"""


function main()
    ch1 = Channel()
    ch2 = Channel()
    @async worker(ch1, 1)
    @async worker(ch2, 2)

    # すべてのチャンネルが閉じるまで待機
    @sync begin
        @async begin
            while isopen(ch1)
                take!(ch1) |> println
            end
        end
        @async begin
            while isopen(ch2)
                take!(ch2) |> println
            end
        end
    end
end
    
