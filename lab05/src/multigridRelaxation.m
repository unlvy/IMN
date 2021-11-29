function [S_vec_vec, it_vec] = multigridRelaxation(borders, x_max, y_max, n_x, n_y, delta, k, TOL)
        
    % macierz bedaca siatka obliczeniowa
    V = zeros(n_x + 1, n_y + 1);
        
    % wektory na S
    S_vec_vec = cell(sqrt(k) + 1, 1);
    
    % wektor na ilosc iteracji
    it_vec = zeros(sqrt(k) + 1, 1);
    
    index = 1;
    
    while k >= 1
        
        % warunki brzegowe (pierwszy i ostatni rzad)
        for i = 1 : n_x + 1 
           V(i, 1) = borders{4}((i - 1) * delta);
           V(i, n_y + 1) = borders{2}((i - 1) * delta);
        end

        % warunki brzegowe (pierwsza i ostatnia kolumna)
        for i = 1 : n_y + 1
            V(1, i) = borders{1}((i - 1) * delta);
            V(n_x + 1, i) = borders{3}((i - 1) * delta);
        end
                
        S_prev = 1;
        it = 0;
        
        while true
            % wypelnienie siatki
            for i = (k + 1) : (k) : (n_x - k + 1)
                for j = (k + 1) : (k) : (n_y - k + 1)
                    V(i, j) = 0.25 * (V(i + k, j) + V(i - k, j)...
                            + V(i, j + k) + V(i, j - k));
                end
            end

            % obliczenie S
            m = (k * delta)^2 / 2;
            d = 2 * k * delta;
            S = 0;
            for i = (1) : (k) : (n_x - k + 1)
                for j = (1) : (k) : (n_y - k + 1)
                    S = S + m * (((V(i + k, j) - V(i, j))/d + ((V(i + k, j + k)...
                        - V(i, j + k))/d))^2 + ((V(i, j + k) - V(i, j))/d + ...
                        ((V(i + k, j + k) - V(i + k, j))/d))^2);
                end
            end

            % sprawdzenie warunku stopu
            if abs((S - S_prev) / S_prev) < TOL
                break
            end
            
            % nadpisanie zmiennych
            S_prev = S;
            it = it + 1;
            S_vec_vec{index}(it) = S;
            

        end
                
        % utworzenie wykresu
        p_name = sprintf('%s%d', 'V: k = ', k);
        p_title = sprintf('%s%d', 'Mapa zrelaksowanego potencjału V(x,y) dla k = ', k);
        p_path = sprintf('%s%d%s', '../charts/MR_V_', k, '.bmp');
        fig = figure('Name', p_name, 'NumberTitle', 'off');
        hold on;
        surf(0:delta*k:x_max, 0:delta*k:y_max, (V(1:k:end, 1:k:end))', 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
        xlim([0, x_max]);
        ylim([0, y_max]);
        view(2);
        title(p_title);
        xlabel('x');
        ylabel('y');
        colorbar('Ticks', -1:0.25:1);
        hold off;
        saveas(fig, p_path);

        % zageszczenie siatki
        k_half = fix(k / 2);
        for i = (1) : (k) : (n_x - k + 1)
            for j = (1) : (k) : (n_y - k + 1)
                V(i + k_half, j + k_half) = 0.25 * (V(i, j) + V(i + k, j)...
                    + V(i, j + k) + V(i + k, j + k));
                V(i + k_half, j) = 0.5 * (V(i, j) + V(i + k, j));
                V(i, j + k_half) = 0.5 * (V(i, j) + V(i, j + k));
            end
        end

        k = fix(k / 2);
        it_vec(index) = it;
        index = index + 1;
        
    end
    
    % wykres S(it)
    p_name = sprintf('%s', 'S(it)');
    p_title = sprintf('%s', 'Wykresy S^(^k^) = S(it)');
    p_path = sprintf('%s', '../charts/S(it).bmp');
    fig = figure('Name', p_name, 'NumberTitle', 'off');
    hold on;
    for i = 1:5
        if i == 1
            start = 1;
            stop =  it_vec(i);
        else
            start = stop + 1;
            stop = stop + it_vec(i);
        end       
        plot(start:stop, S_vec_vec{i}(1:stop - start + 1));
    end
    legend('k = 16', 'k = 8', 'k = 4', 'k = 2', 'k = 1');
    title(p_title);
    xlabel('it');
    ylabel('S');
    hold off;
    saveas(fig, p_path);
    
end
