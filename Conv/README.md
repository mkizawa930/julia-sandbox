# Conv

This is a julia package for convolutional code.

## Convolutional Encoding

```julia
using Conv

# generate a 171 133 trellis(no feedback).
trellis = poly2trellis([171 133])

import Random
rowbits = Ranodm.bitrand(100);
encodedbits = encode(rowbits, trellis=trellis)
```


