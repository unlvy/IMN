function [S_vec, it, V] = localRelaxation(epsilon, delta, n_x, n_y, rho, TOL, omega_L, V_1, V_2)

    % macierz V
    V = zeros(n_x + 1, n_y + 1);
    
    % wypelnienie warunkow brzegowych
    for i = 1 : n_x + 1
       V(i, 1) = V_1;
       V(i, n_y + 1) = V_2;
    end
    
    % S, iteracja
    S = 0;
    S_prev = 1;
    S_vec = zeros(50000, 1);
    it = 0;

    while true
        
        % wyznaczenie elementow poza brzegowymi
        for i = 2 : n_x
            for j = 2 : n_y
                V(i, j) = (1 - omega_L) * V(i, j) + (omega_L / 4) * (V(i + 1, j) ...
                        + V(i - 1, j) + V(i, j + 1) + V(i, j - 1) ...
                        + delta^2 / epsilon *  rho(i, j));                        
            end
        end

        % uwzględnienie WB Neumanna
        for j = 2 : n_y
            V(1, j) = V(2, j);
            V(n_x + 1, j) = V(n_x, j);
        end

        % obliczenie wartosci S
        for i = 1 : n_x
            for j = 1 : n_y
                S = S + delta^2 * ( 0.5 * ( (V(i + 1, j) - V(i, j) ) / delta )^2 ...
                    + 0.5 * ( (V(i, j + 1) - V(i, j) ) / delta )^2 - rho(i, j) * V(i, j));
            end
        end

        % sprawdzenie warunku
        if ( abs( (S - S_prev) / S_prev ) < TOL)
            break;
        end

        % nadpisanie wartosci zmiennych
        S_prev = S;
        S = 0;
        it = it + 1;
        S_vec(it) = S_prev;
        
    end  
    
end
