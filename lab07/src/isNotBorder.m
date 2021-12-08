function [flag] = isNotBorder(i, j, i_1, j_1)

    i = i - 1;
    j = j - 1;
    
    flag = false;
    
    if ((i <= i_1 && j > j_1) || (i > i_1))
        flag = true;
    end
    
end

