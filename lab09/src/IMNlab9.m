
iters = [100 200 500 1000 2000];

N_X = 39;
N_Y = 39;

for it = 1 : length(iters)

    % T
    fpath = sprintf('%s%d%s', '../results/T_', iters(it), '.dat');
    file = fopen(fpath, 'r');
    temp = (fscanf(file, '%f'))';
    fclose(file);
    T = zeros(N_X);
    for i = 1 : N_X
        T(i, :) = temp((i-1) * N_X+1 : i * N_X);
    end


    fig = figure('Name', 'T', 'NumberTitle', 'off');
    hold on;
    surf(0:1:N_X-1, 0:1:N_Y-1, T', 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
    xlim([0, N_X-1]);
    ylim([0, N_Y-1]);
    view(2);
    p_title = sprintf('%s%d', 'T\_', iters(it));
    title(p_title);
    xlabel('x');
    ylabel('y');
    colorbar;
    colormap turbo;
    hold off;
    p_path = sprintf('%s%d%s', '../charts/T_', iters(it), '.bmp');
    saveas(fig, p_path);
    
    % grad2T
    fpath = sprintf('%s%d%s', '../results/DT_', iters(it), '.dat');
    file = fopen(fpath, 'r');
    temp = (fscanf(file, '%f'))';
    fclose(file);
    T = zeros(N_X);
    for i = 1 : N_X
        T(i, :) = temp((i-1) * N_X+1 : i * N_X);
    end


    fig = figure('Name', 'grad2T', 'NumberTitle', 'off');
    hold on;
    surf(0:1:N_X-1, 0:1:N_Y-1, T', 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
    xlim([0, N_X-1]);
    ylim([0, N_Y-1]);
    view(2);
    p_title = sprintf('%s%d', '\DeltaT\_', iters(it));
    title(p_title);
    xlabel('x');
    ylabel('y');
    colorbar;
    colormap turbo;
    hold off;
    p_path = sprintf('%s%d%s', '../charts/grad2T_', iters(it), '.bmp');
    saveas(fig, p_path);

end

