defmodule Sort do

    def qs([]), do: []
    def qs([h|t]) do
        l = for x <- t, x < h, do: x
        r = for x <- t, x >= h, do: x
        qs(l) ++ [h] ++ qs(r)
    end

end
