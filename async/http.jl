using HTTP
using Base.Threads


# 指定のURLからファイルをダウンロードする
function download(url, timeout=180)
    filename = basename(url)
    try
        @info "threadid=$(threadid()): download start $(filename)"
        res = HTTP.get(url, readtimeout=timeout)
        @info "threadid=$(threadid()): download finished $(filename)"
        return (filename=filename, filecontent=res.body)
    catch e
        @error e
        return
    end
end


function main()
    urls = [
        "https://archive.org/download/ThePianoMusicOfMauriceRavel/01PavanePourUneInfanteDfuntePourPianoMr19.mp3",
        "https://archive.org/download/ThePianoMusicOfMauriceRavel/02JeuxDeauPourPianoMr30.mp3",
        "https://archive.org/download/ThePianoMusicOfMauriceRavel/03SonatinePourPianoMr40-Modr.mp3",
        "https://archive.org/download/ThePianoMusicOfMauriceRavel/04MouvementDeMenuet.mp3",
        "https://archive.org/download/ThePianoMusicOfMauriceRavel/05Anim.mp3",
    ]
    tasks = Task[]
    
    st = time()
    for url in urls
        # 逐次ダウンロードを開始する
        task = @spawn download(url)
        push!(tasks, task)
    end

    @sync for task in tasks
        @async begin
            result = fetch(task)
            result === nothing && ErrorException("download is failed.")
            path = joinpath(dirname(@__FILE__), "tmp", result.filename)
            try
                open(path, "w") do file
                    write(file, result.filecontent)
                end
            catch e
                error(e)
            end
        end
    end
    en = time()
    elapsed_time = (en - st)
    @info "ダウンロードにかかった時間: $(elapsed_time)[s]"
end

main()