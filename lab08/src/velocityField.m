function [V_x, V_y, dt, iters] = velocityField(fpath, c, flag)
    
    % wczytanie funkcji strumienia
    file = fopen(fpath,'r'); 
    psi_file = fscanf(file, '%f');
    fclose(file);

    % funkcja strumienia
    psi = zeros(c.n_x + 1, c.n_y + 1);
    for i = 1 : 3 : length(psi_file)
        psi(psi_file(i) + 1, psi_file(i + 1) + 1) = psi_file(i + 2);
    end
    
    % pole predkosci
    V_x = zeros(c.n_x + 1, c.n_y + 1);
    V_y = zeros(c.n_x + 1, c.n_y + 1);
    
    % wnetrze
    for i = 2 : c.n_x
        for j = 2 : c.n_y
            V_x(i, j) = (psi(i, j + 1) - psi(i, j - 1)) / (2 * c.delta);
            V_y(i, j) = -(psi(i + 1, j) - psi(i - 1, j)) / (2 * c.delta);
        end
    end

    % zastawka
    for i = c.i_1 + 1 : c.i_2 + 2
        for j = 1 : c.j_1 + 1
            V_x(i, j) = 0;
            V_y(i, j) = 0;
        end
    end
    
    % dolny i gorny brzeg
    for i = 2 : c.n_x
        V_x(i, 1) = 0;
        V_y(i, c.n_y + 1) = 0;
    end
    
    % lewy i prawy brzeg
    for j = 1 : c.n_y + 1
        V_x(1, j) = V_x(2, j);
        V_x(c.n_x + 1, j) = V_x(c.n_x, j);
    end
    
    % wykres
    if flag
        fig = figure('Name', 'velocity', 'NumberTitle', 'off');
        hold on;
        colormap cool;
        x = 0 : c.delta : c.n_x * c.delta;
        y = 0 : c.delta : c.n_y * c.delta;
        subplot(2, 1, 1);
        surf(x, y, V_x', 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
        view(2);
        p_title = '{\itV_x}({\itx, y})';
        title(p_title);
        xlim([0 c.n_x * c.delta]);
        ylim([0 c.n_y * c.delta]);
        xlabel('x');
        ylabel('y');
        grid off;
        set(gca,'color','k')

        subplot(2, 1, 2);
        surf(x, y, V_y', 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
        view(2);
        p_title = '{\itV_y}({\itx, y})';
        title(p_title);
        xlim([0 c.n_x * c.delta]);
        ylim([0 c.n_y * c.delta]);
        xlabel('x');
        ylabel('y');
        set(gca,'color','k')
        grid off;

        hold off;
        saveas(fig, '../charts/Vx_Vy.bmp');
    end
    
    % krok czasowy
    max = sqrt(V_x(1, 1)^2 + V_y(1, 1)^2);
    for i = 1 : c.n_x + 1
        for j = 1 : c.n_y + 1
            temp = sqrt(V_x(i, j)^2 + V_y(i, j)^2);
            if temp > max
                max = temp;
            end
        end
    end
    dt = c.delta / (4  * max);
    
end

