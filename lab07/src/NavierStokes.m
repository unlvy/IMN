function [] = NavierStokes(Q_we, ex)

    % przyjete stale
    DELTA = 0.01;
    rho = 1;
    mu = 1;
    n_x = 200;
    n_y = 90;
    i_1 = 50;
    j_1 = 55;
    IT_MAX = 20000;
       
    Q_wy = Q_we * ((DELTA * n_y)^3 - (DELTA * j_1)^3 - 3 * ...
        (DELTA * j_1) * (DELTA * n_y)^2 + 3 * (DELTA * j_1)^2 ...
        * (DELTA * n_y)) / (DELTA * n_y)^3;

    % ustalenie WB psi
    psi = psiBorders(DELTA, mu, n_x, n_y, Q_we, Q_wy, i_1, j_1);
    % zeta
    zeta = zeros(n_x + 1, n_y + 1);
    
    % wypelnienie NaNem
    psi(1 : i_1, 1 : j_1) = NaN;
    zeta(1 : i_1, 1 : j_1) = NaN;

    for it = 1 : IT_MAX
    
        if it < 2000
            Q = 0;
        else
            Q = 1;
        end
        
        for i = 2 : n_x
            for j = 2 : n_y
                if isNotBorder(i, j, i_1, j_1)
                    % wz. 8
                    psi(i, j) = (psi(i + 1, j) + psi(i - 1, j) + ...
                        psi(i, j + 1) + psi(i, j - 1) - DELTA^2 * ...
                        zeta(i, j)) / 4;
                    % wz. 9
                    zeta(i, j) = (zeta(i + 1, j) + zeta(i - 1, j) + ...
                        zeta(i, j + 1) + zeta(i, j - 1)) / 4 - ...
                        Q * rho / (16 * mu) * ((psi(i, j + 1) - ...
                        psi(i, j - 1)) * (zeta(i + 1, j) - zeta(i - 1, j)) - ...
                        ((psi(i + 1, j) - psi(i - 1, j)) * (zeta(i, j + 1) - ...
                        zeta(i, j - 1))));
                end
            end
        end
        
        zeta = zetaBorders(DELTA, mu, n_x, n_y, Q_we, Q_wy, i_1, j_1, psi, zeta);
        ERR = 0;
        for i = 2 : n_x
            ERR = ERR + (psi(i + 1, j_1 + 3) + psi(i - 1, j_1 + 3) + ...
                psi(i, j_1 + 4) + psi(i, j_1 + 2) - 4 * psi(i, j_1 + 3) - ...
                DELTA^2 * zeta(i, j_1 + 3));
        end
%         disp('it = ');
%         disp(it);
%         disp(ERR);
        
    end
    
    U = zeros(n_x + 1, n_y + 1);
    V = zeros(n_x + 1, n_y + 1);
    
    U(1 : i_1, 1 : j_1) = NaN;
    V(1 : i_1, 1 : j_1) = NaN;
    
    % U i V
    for i = 2 : n_x
        for j = 2 : n_y
            if i >= i_1 || j >= j_1
                U(i, j) = (psi(i, j + 1) - psi(i, j - 1)) / (2 * DELTA);
                V(i, j) = -(psi(i + 1, j) - psi(i - 1, j)) / (2 * DELTA);
            end
        end
    end
    
    % wykresy
    p_name = sprintf('Q = %d', Q_we);
    p_path = sprintf('%s%d.bmp', '../charts/', ex);
    p_title =  '\psi({\itx, y})';
    
    % 1. psi(x, y)
    fig = figure('Name', p_name, 'NumberTitle', 'off');
    hold on;

    colormap jet;
    
    subplot(2, 2, 1);
    contourf(0:0.01:2, 0:0.01:0.9, psi', 40);
    title(p_title);
    xlabel('x');
    ylabel('y');
    hold off;
        
    % 2. zeta(x, y)
    p_title = '\zeta({\itx, y})';
    subplot(2, 2, 2);
    contourf(0:0.01:2, 0:0.01:0.9, zeta', 40);
    title(p_title);
    xlabel('x');
    ylabel('y');
    
    % 3. U(x, y)
    p_title = '{\itU}({\itx, y})';
    subplot(2, 2, 3);
    surf(0:0.01:2, 0:0.01:0.9, U', 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
    view(2);
    title(p_title);
    xlim([0 2]);
    ylim([0 0.9]);
    xlabel('x');
    ylabel('y');
    grid off;

    % 4. V(x, y)
    p_title = '{\itV}({\itx, y})';
    subplot(2, 2, 4);
    surf(0:0.01:2, 0:0.01:0.9, V', 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
    view(2);
    title(p_title);
    xlabel('x');
    ylabel('y');
    xlim([0 2]);
    ylim([0 0.9]);
    grid off;
        
    colorbar('Position', [0.93  0.3  0.03  0.5])
    
    hold off;
    saveas(fig, p_path);
    
end

