function [result] = isFloodgate(c, i, j)
    i = i - 1;
    j = j - 1;
    result = false;
    if i >= c.i_1 && i <= c.i_2 && j <= c.j_1
        result = true;
    end
end

