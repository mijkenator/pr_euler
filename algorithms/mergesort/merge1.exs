defmodule Sort do

    def m_s([l]), do: [l]
    def m_s(list) do
        {l, r} = Enum.split(list, div(length(list), 2))        
        :lists.merge(m_s(l), m_s(r))
    end

end
