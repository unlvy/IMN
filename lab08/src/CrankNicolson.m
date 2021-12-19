function [t_vec, ct_vec, xsr_vec] = CrankNicolson(c, V_x, V_y, dt, D)
    
    IT_MAX = c.it;
    u_0 = zeros(c.n_x + 1, c.n_y + 1);
    % inicjalizacja gestosci
    for i = 1 : c.n_x + 1
        for j = 1 : c.n_y + 1
            x = (i - 1) * c.delta;
            y = (j - 1) * c.delta;
            u_0(i, j) = 1 / (2 * pi * c.sigma^2) * exp(-((x - c.x_A)^2 + ...
                (y - c.y_A)^2) / (2 * c.sigma^2));
        end
    end
        
    t = 0;
    t_vec = zeros(IT_MAX, 1);
    ct_vec = zeros(IT_MAX, 1);
    xsr_vec = zeros(IT_MAX, 1);
    % glowna petla
    for it = 1 : IT_MAX 
        
        % inicjalizacja kolejnego kroku
        u_1 = u_0;
        % iteracja Picarda
        for k = 1 : 20
            for i = 1 : c.n_x + 1
                for j = 2 : c.n_y
                    if isFloodgate(c, i, j)
                        continue;
                    elseif i == 1
                         u_1(i, j) = (1 / (1 + ((2 * D * dt) / (c.delta^2))))...
                            * (u_0(i, j) - (dt / 2) * V_x(i, j)...
                            * (((u_0(i + 1, j) - u_0(c.n_x + 1, j))...
                            / (2 * c.delta)) + (u_1(i + 1, j) - u_1(c.n_x + 1, j))...
                            / (2 * c.delta)) - (dt / 2) * V_y(i, j)...
                            * ((u_0(i, j + 1) - u_0(i, j - 1))...
                            / (2 * c.delta) + (u_1(i, j + 1) - u_1(i, j - 1))...
                            / (2 * c.delta)) + (dt  / 2) * D * ((u_0(i + 1, j)...
                            + u_0(c.n_x + 1, j) + u_0(i, j + 1) + u_0(i, j - 1)...
                            - 4 * u_0(i, j)) / (c.delta^2) + (u_1(i + 1, j)...
                            + u_1(c.n_x + 1, j) + u_1(i, j + 1) + u_1(i, j - 1)) / (c.delta^2)));
                    elseif i == c.n_x + 1
                         u_1(i, j) = (1 / (1 + ((2 * D * dt) / (c.delta^2))))...
                            * (u_0(i, j) - (dt / 2) * V_x(i, j)...
                            * (((u_0(1, j) - u_0(i - 1, j))...
                            / (2 * c.delta)) + (u_1(1, j) - u_1(i - 1, j))...
                            / (2 * c.delta)) - (dt / 2) * V_y(i, j)...
                            * ((u_0(i, j + 1) - u_0(i, j - 1))...
                            / (2 * c.delta) + (u_1(i, j + 1) - u_1(i, j - 1))...
                            / (2 * c.delta)) + (dt  / 2) * D * ((u_0(1, j)...
                            + u_0(i - 1, j) + u_0(i, j + 1) + u_0(i, j - 1)...
                            - 4 * u_0(i, j)) / (c.delta^2) + (u_1(1, j)...
                            + u_1(i - 1, j) + u_1(i, j + 1) + u_1(i, j - 1)) / (c.delta^2)));
                    else
                        u_1(i, j) = (1 / (1 + ((2 * D * dt) / (c.delta^2))))...
                            * (u_0(i, j) - (dt / 2) * V_x(i, j)...
                            * (((u_0(i + 1, j) - u_0(i - 1, j))...
                            / (2 * c.delta)) + (u_1(i + 1, j) - u_1(i - 1, j))...
                            / (2 * c.delta)) - (dt / 2) * V_y(i, j)...
                            * ((u_0(i, j + 1) - u_0(i, j - 1))...
                            / (2 * c.delta) + (u_1(i, j + 1) - u_1(i, j - 1))...
                            / (2 * c.delta)) + (dt  / 2) * D * ((u_0(i + 1, j)...
                            + u_0(i - 1, j) + u_0(i, j + 1) + u_0(i, j - 1)...
                            - 4 * u_0(i, j)) / (c.delta^2) + (u_1(i + 1, j)...
                            + u_1(i - 1, j) + u_1(i, j + 1) + u_1(i, j - 1)) / (c.delta^2)));
                    end
                end
            end
            
        end
        
        u_0 = u_1;
       
        ct = 0;
        xsr = 0;
        for i = 1 : c.n_x + 1
            for j = 1 : c.n_y + 1
                ct = ct + u_0(i, j) * c.delta^2;
                xsr = xsr + u_0(i, j) * c.delta^2 * (i - 1) * c.delta;
            end
        end
        
        t_vec(it) = t;
        ct_vec(it) = ct;
        xsr_vec(it) = xsr;
        
        if mod(it, round(IT_MAX / 5)) == 0
            fig = figure('Name', 'map', 'NumberTitle', 'off');
            hold on;
            colormap cool;
            x = 0 : c.delta : c.n_x * c.delta;
            y = 0 : c.delta : c.n_y * c.delta;
            surf(x, y, u_0', 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
            view(2);
            p_title = '{\itu}({\itx, y}), {\itt}=';
            temp = sprintf('%.1f', it/IT_MAX);
            p_title = strcat(p_title, temp);
            temp = '{\itt_M_A_X}';
            p_title = strcat(p_title, temp);
            title(p_title);
            xlim([0 c.n_x * c.delta]);
            ylim([0 c.n_y * c.delta]);
            xlabel('x');
            ylabel('y');
            grid off;
            set(gca,'color','k')
            hold off;
            p_path = sprintf('../charts/u(x,y)_%d_%.1f.bmp', D, it/IT_MAX);
            %saveas(fig, p_path);
        end
        
        t = t + dt;    
        
    end
    
    
    
end

