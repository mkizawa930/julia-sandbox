using HTTP
using HTTP.WebSockets
using URIs
using JSON3, StructTypes

uri = URI(scheme="wss", host="ws.lightstream.bitflyer.com", path="/json-rpc")
string(uri)

msg = """
{
    "version": "2.0",
    "method": "subscribe",
    "params": {
        "channel": "lightning_ticker_BTC_JPY"
    }
}
"""

const Optional{T} = Union{Nothing, T}

struct Ticker
    product_code::String
    state::String
    timestamp::String
    tick_id::Optional{Float64}
    best_bid::Optional{Float64}
    best_ask::Optional{Float64}
    best_bid_size::Optional{Float64}
    best_asksize::Optional{Float64}
    total_bid_depth::Optional{Float64}
    total_ask_depth::Optional{Float64}
    market_bid_size::Optional{Float64}
    market_ask_size::Optional{Float64}
    ltp::Optional{Float64}
    volume::Optional{Float64}
    volume_by_product::Optional{Float64}
end
StructTypes.StructType(::Type{Ticker}) = StructTypes.Struct()

function main()
    WebSockets.open(string(uri)) do ws
        try 
            # when open
            send(ws, msg)
            for msg in ws
                json = JSON3.read(msg)
                !haskey(json, :params) && continue

                for (key, val) in json.params
                    if key == :message
                        # println(val)
                        val = JSON3.write(val)
                        @show JSON3.read(val, Ticker)
                    end
                end
            end
        catch e
            @error e
            close(ws)
        end
    end
end

function realtime_ticker(chan::Channel)
    WebSockets.open(string(uri)) do ws
        try 
            # when open
            send(ws, msg)
            for msg in ws
                json = JSON3.read(msg)
                !haskey(json, :params) && continue

                for (key, val) in json.params
                    if key == :message
                        # println(val)
                        str = JSON3.write(val)
                        put!(chan, JSON3.read(str, Ticker))
                    end
                end
            end
        catch e
            @error e
            close(ws)
        end
    end
end
