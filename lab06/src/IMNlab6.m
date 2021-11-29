clc; clear;

nx = 51;
ny = 51;
file = fopen('../results/V_2_50.dat', 'r');
temp = (fscanf(file, '%f'))';
fclose(file);
V_2_50 = zeros(nx);
for i = 1 : nx
    V_2_50(i, :) = temp((i-1)*nx+1 : i*nx);
end


fig = figure('Name', '2a', 'NumberTitle', 'off');
hold on;
surf(0:1:nx-1, 0:1:ny-1, V_2_50, 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
xlim([0, nx-1]);
ylim([0, ny-1]);
view(2);
title('2a: nx=ny=50, \epsilon_1 = 1, \epsilon_2 = 1');
xlabel('x');
ylabel('y');
colorbar;
colormap hot;
hold off;
saveas(fig, "../charts/2a.bmp");

nx = 101;
ny = 101;
file = fopen('../results/V_2_100.dat', 'r');
temp = (fscanf(file, '%f'))';
fclose(file);
V_2_100 = zeros(nx);
for i = 1 : nx
    V_2_100(i, :) = temp((i-1)*nx+1 : i*nx);
end


fig = figure('Name', '2b', 'NumberTitle', 'off');
hold on;
surf(0:1:nx-1, 0:1:ny-1, V_2_100, 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
xlim([0, nx-1]);
ylim([0, ny-1]);
view(2);
title('2b: nx=ny=100, \epsilon_1 = 1, \epsilon_2 = 1');
xlabel('x');
ylabel('y');
colorbar;
colormap hot;
hold off;
saveas(fig, "../charts/2b.bmp");

nx = 201;
ny = 201;
file = fopen('../results/V_2_200.dat', 'r');
temp = (fscanf(file, '%f'))';
fclose(file);
V_2_200 = zeros(nx);
for i = 1 : nx
    V_2_200(i, :) = temp((i-1)*nx+1 : i*nx);
end


fig = figure('Name', '2c', 'NumberTitle', 'off');
hold on;
surf(0:1:nx-1, 0:1:ny-1, V_2_200, 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
xlim([0, nx-1]);
ylim([0, ny-1]);
view(2);
title('2c: nx=ny=200, \epsilon_1 = 1, \epsilon_2 = 1');
xlabel('x');
ylabel('y');
colorbar;
colormap hot;
hold off;
saveas(fig, "../charts/2c.bmp");

nx = 101;
ny = 101;
file = fopen('../results/V_3_1.dat', 'r');
temp = (fscanf(file, '%f'))';
fclose(file);
V_3_1 = zeros(nx);
for i = 1 : nx
    V_3_1(i, :) = temp((i-1)*nx+1 : i*nx);
end


fig = figure('Name', '3a', 'NumberTitle', 'off');
hold on;
surf(0:1:nx-1, 0:1:ny-1, V_3_1, 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
xlim([0, nx-1]);
ylim([0, ny-1]);
view(2);
title('3a: nx=ny=100, \epsilon_1 = 1, \epsilon_2 = 1');
xlabel('x');
ylabel('y');
colorbar;
colormap hot;
hold off;
saveas(fig, "../charts/3a.bmp");


file = fopen('../results/V_3_2.dat', 'r');
temp = (fscanf(file, '%f'))';
fclose(file);
V_3_2 = zeros(nx);
for i = 1 : nx
    V_3_2(i, :) = temp((i-1)*nx+1 : i*nx);
end


fig = figure('Name', '3b', 'NumberTitle', 'off');
hold on;
surf(0:1:nx-1, 0:1:ny-1, V_3_2, 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
xlim([0, nx-1]);
ylim([0, ny-1]);
view(2);
title('3b: nx=ny=100, \epsilon_1 = 1, \epsilon_2 = 2');
xlabel('x');
ylabel('y');
colorbar;
colormap hot;
hold off;
saveas(fig, "../charts/3b.bmp");

file = fopen('../results/V_3_3.dat', 'r');
temp = (fscanf(file, '%f'))';
fclose(file);
V_3_3 = zeros(nx);
for i = 1 : nx
    V_3_3(i, :) = temp((i-1)*nx+1 : i*nx);
end


fig = figure('Name', '3c', 'NumberTitle', 'off');
hold on;
surf(0:1:nx-1, 0:1:ny-1, V_3_3, 'FaceColor', 'TextureMap', 'EdgeColor', 'None');
xlim([0, nx-1]);
ylim([0, ny-1]);
view(2);
title('3c: nx=ny=100, \epsilon_1 = 1, \epsilon_2 = 10');
xlabel('x');
ylabel('y');
colorbar;
colormap hot;
hold off;
saveas(fig, "../charts/3c.bmp");