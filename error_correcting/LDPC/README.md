# LDPC


## Example

```julia
using LDPC


# loading
src = "." # LDPC符号が保存されているパス
G, H = LDPC.load(src, rows=256, cols=512)


# encoding
rowbits = Random.bitrand(256)
encodedbits = LDPC.encode(x, G)

# decoding
options = (
  
)
decodedbits = LDPC.decode(y, options=options)

```
