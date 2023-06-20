# 構文解析
ex = Meta.parse("1 + 1")
eval(ex)

# Juliaの式 :()
ex = :(:+, 1, 1)


"""
マクロの引数はjuliaの構文を引数にとる
"""
macro plus1(ex)
    # escで
    :($(esc(ex)) + 1)
end
@plus1 2
@macroexpand @plus1 2