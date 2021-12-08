function [psi] = psiBorders(DELTA, mu, n_x, n_y, Q_we, Q_wy, i_1, j_1)

    % psi
    psi = zeros(n_x + 1, n_y + 1);

    % brzeg A
    for j = j_1 + 1 : n_y + 1
        psi(1, j) = (Q_we / (2 * mu)) * (((DELTA * (j - 1))^3) / 3 - ...
            ((DELTA * (j - 1))^2) / 2 * (j_1 * DELTA + n_y * DELTA) + ...
            (j - 1) * DELTA * j_1 * DELTA *  n_y * DELTA);
    end

    % brzeg C
    for j = 1 : n_y + 1
        psi(n_x + 1, j) = (Q_wy / (2 * mu)) * (((DELTA * (j - 1))^3) / 3 - ...
            ((DELTA * (j - 1))^2) / 2 * n_y * DELTA) + (Q_we * (DELTA * j_1)^2 ...
            * (3 * DELTA * n_y - DELTA * j_1)) / (12 * mu);
    end

    % brzeg B
    for i = 2 : n_x
        psi(i, n_y + 1) = psi(1, n_y + 1);
    end

    % brzeg D
    for i = i_1 + 1 : n_x
        psi(i, 1) = psi(1, j_1 + 1);
    end
    
    % brzeg E
    for j = 2 : j_1 + 1
        psi(i_1 + 1, j) = psi(1, j_1 + 1);
    end   
    
    % brzeg F
    for i = 2 : i_1 + 1
        psi(i, j_1 + 1) = psi(1, j_1 + 1);
    end   

end

