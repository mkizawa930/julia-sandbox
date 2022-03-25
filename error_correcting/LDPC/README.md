# LDPC


## Example

```julia
using LDPC


# loading
src = "." # LDPC符号が保存されているパス
G, H = LDPC.load(src, rows=256, cols=512)

encoder = LDPC.Encoder(G)
decoder = LDPC.Decoder(H)




# encoding
row_bits = Random.bitrand(256)
encoded_bits = encoder(row_bits)

# channel
## you must implement a channel function.
received_bits = channel(encodedbits)

# decoding
decoded_bits = decoder(received_bits)


```
