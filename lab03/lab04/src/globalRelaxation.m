function [S_vec, it, V_n] = globalRelaxation(epsilon, delta, n_x, n_y, rho, TOL, omega_G, V_1, V_2)

    % macierze stara i nowa
    V_s = zeros(n_x + 1, n_y + 1);
    V_n = zeros(n_x + 1, n_y + 1);
    
    % wypelnienie warunkow brzegowych
    for i = 1 : n_x + 1
       V_s(i, 1) = V_1;
       V_s(i, n_y + 1) = V_2;
       V_n(i, 1) = V_1;
       V_n(i, n_y + 1) = V_2;
    end
    
    % S, iteracja
    S_prev = 1;
    S_vec = zeros(50000, 1);
    it = 0;

     while true

        % wyznaczenie elementow poza brzegowymi
        for i = 2 : n_x
            for j = 2 : n_y
                V_n(i, j) = 0.25 * ( V_s(i + 1, j) + V_s(i - 1, j) + ...
                            V_s(i, j + 1) + V_s(i, j - 1) + delta^2 / epsilon *  rho(i, j) );
            end
        end

        % uwzględnienie WB Neumanna
        for j = 2 : n_y
            V_n(1, j) = V_n(2, j);
            V_n(n_x + 1, j) = V_n(n_x, j);
        end

        % mieszanie obu rozwiązań
        V_s = (1 - omega_G) * V_s + omega_G * V_n;

        % obliczenie wartosci S
        S = 0;
        for i = 1 : n_x
            for j = 1 : n_y
                S = S + delta^2 * ( 0.5 * ( (V_n(i + 1, j) - V_n(i, j) ) / delta )^2 ...
                    + 0.5 * ( (V_n(i, j + 1) - V_n(i, j) ) / delta )^2 - rho(i, j) * V_n(i, j));
            end
        end

        % sprawdzenie warunku
        if ( abs( (S - S_prev) / S_prev ) < TOL)
            break;
        end

        % nadpisanie wartosci zmiennych
        S_prev = S;
        it = it + 1;
        S_vec(it) = S_prev;
        
    end  
    
end
