# Conv


## Encoding with Trellis

```julia
using Conv

# An array of octal number for shift register is required.
trellis = poly2trellis([171 133])

using Random
rowbits = bitrand(100);
encodedbits = encode(rowbits, trellis=trellis)
```


