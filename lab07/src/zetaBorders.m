function [zeta] = zetaBorders(DELTA, mu, n_x, n_y, Q_we, Q_wy, i_1, j_1, psi, zeta)

    % zeta
        
    % brzeg A
    for j = j_1 + 1 : n_y + 1
        zeta(1, j) = Q_we / (2 * mu) * (2 * DELTA * (j - 1) - j_1 * DELTA - n_y * DELTA);
    end
    
    % brzeg C
    for j = 1 : n_y + 1
        zeta(n_x + 1, j) = Q_wy / (2 * mu) * (2 * DELTA * (j - 1) - n_y * DELTA);
    end
    
    % brzeg B
    for i = 2 : n_x
        zeta(i, n_y + 1) = 2 / DELTA^2 * (psi(i, n_y) - psi(i, n_y + 1));
    end
    
    % brzeg D
    for i = i_1 + 2 : n_x
        zeta(i, 1) = 2 / DELTA^2 * (psi(i, 2) - psi(i, 1));
    end
    
    % brzeg E
    for j = 2 : j_1
        zeta(i_1 + 1, j) = 2 / DELTA^2 * (psi(i_1 + 2, j) - psi(i_1 + 1, j));
    end
    
    % brzeg F
    for i = 2 : i_1 + 1
        zeta(i, j_1 + 1) = 2 / DELTA^2 * (psi(i, j_1 + 2) - psi(i, j_1 + 1));
    end
    
    % wierzcholek E/F
    zeta(i_1 + 1, j_1 + 1) = 0.5 * (zeta(i_1, j_1 + 1) + zeta(i_1 + 1, j_1));
    
end

