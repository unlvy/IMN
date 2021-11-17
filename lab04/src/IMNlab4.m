clear; clc;

% przyjęte wartości parametrów
epsilon = 1;
delta = 0.1;
n_x = 150;
n_y = 100;
V_1 = 10;
V_2 = 0;
x_max = delta * n_x;
y_max = delta * n_y;
sigma_x = 0.1 * x_max;
sigma_y = 0.1 * y_max;

% funkcje rho
rho_1 = @(x, y) (1 * exp( ( (-(x - 0.35 * x_max)^2) / sigma_x^2) ...
        - ( ( (y - 0.5 * y_max)^2) / sigma_y^2) ));
rho_2 = @(x, y) ((-1) * exp( ( (-(x - 0.65 * x_max)^2) / sigma_x^2) ...
        - ( ( (y - 0.5 * y_max)^2) / sigma_y^2) ));
rho = @(x, y) (rho_1((x - 1) * delta, (y - 1) * delta) + ...
    + rho_2((x - 1) * delta, (y - 1) * delta));

% 1.1 Relaksacja globalna dla omega_G = 0.6
[S1_vec, it1, V1_G] = globalRelaxation(epsilon, delta, n_x, n_y, rho, 10^(-8), 0.6, V_1, V_2);
% 1.2 Relaksacja globalna dla omega_G = 1.0
[S2_vec, it2, V2_G] = globalRelaxation(epsilon, delta, n_x, n_y, rho, 10^(-8), 1.0, V_1, V_2);
% 2.1 Relaksacja lokalna dla omega_L = 1.0
[S1_vec_L, it1_L, V1_L] = localRelaxation(epsilon, delta, n_x, n_y, rho, 10^(-8), 1.0, V_1, V_2);
% 2.2 Relaksacja lokalna dla omega_L = 1.4
[S2_vec_L, it2_L, V2_L] = localRelaxation(epsilon, delta, n_x, n_y, rho, 10^(-8), 1.4, V_1, V_2);
% 2.3 Relaksacja lokalna dla omega_L = 1.8
[S3_vec_L, it3_L, V3_L] = localRelaxation(epsilon, delta, n_x, n_y, rho, 10^(-8), 1.8, V_1, V_2);
% 2.4 Relaksacja lokalna dla omega_L = 1.9
[S4_vec_L, it4_L, V4_L] = localRelaxation(epsilon, delta, n_x, n_y, rho, 10^(-8), 1.9, V_1, V_2);

% wykresy S = S(it) dla GR
fig = figure('Name','GR_S(t)','NumberTitle','off');
hold on;
set(gca, 'XScale', 'log');
plot(0:1:it1 - 1, S1_vec(1:it1));
plot(0:1:it2 - 1, S2_vec(1:it2));
title('Globalna relaksacja: S(it)');
l1 = sprintf('%s%d', '\omega_G = 0.6, it = ', it1);
l2 = sprintf('%s%d', '\omega_G = 1.0, it = ', it2);
legend(l1, l2);
xlabel('it');
ylabel('S');
xlim([0 30000]);
hold off;
saveas(fig,'../charts/GR_S(it).bmp');

% mapa zrelaksowanego potencjału dla GR_0.6
fig = figure('Name','GR_0.6_V(x,y)','NumberTitle','off');
hold on;
contourf(0:x_max/n_x:x_max, 0:y_max/n_y:y_max, (V1_G)');
title('Mapa zrelaksowanego potencjału V(x,y) dla \omega_G = 0.6');
xlabel('x');
ylabel('y');
hold off;
saveas(fig,'../charts/GR_0.6_V(x,y).bmp');

% mapa zrelaksowanego potencjału dla GR_1.0
fig = figure('Name','GR_1.0_V(x,y)','NumberTitle','off');
hold on;
contourf(0:x_max/n_x:x_max, 0:y_max/n_y:y_max, (V2_G)');
title('Mapa zrelaksowanego potencjału V(x,y) dla \omega_G = 1.0');
xlabel('x');
ylabel('y');
hold off;
saveas(fig,'../charts/GR_1.0_V(x,y).bmp');

ERR_1 = zeros(n_x + 1, n_y + 1);
ERR_2 = zeros(n_x + 1, n_y + 1);
for i = 2 : n_x
    for j = 2 : n_y
        ERR_1(i, j) = (V1_G(i+1, j) - 2 * V1_G(i, j) + V1_G(i-1,j)) ...
                    / (delta^2) + (V1_G(i, j+1) - 2 * V1_G(i, j) + ...
                    V1_G(i, j-1)) / (delta^2) + rho(i, j) / epsilon;
        ERR_2(i, j) = (V2_G(i+1, j) - 2 * V2_G(i, j) + V2_G(i-1,j)) ...
                    / delta^2 + (V2_G(i, j+1) - 2 * V2_G(i, j) + ...
                    V2_G(i, j-1)) / delta^2 + rho(i, j) / epsilon;
    end
end

% wykres dla GR 0.6
fig = figure('Name','GR_0.6_ERR','NumberTitle','off');
hold on;
contourf(0:x_max/n_x:x_max, 0:y_max/n_y:y_max, (ERR_1)');
title('Błąd rozwiązania dla \omega_G = 0.6');
xlabel('x');
ylabel('y');
hold off;
saveas(fig,'../charts/GR_0.6_ERR.bmp');

% wykres dla GR 1.0
fig = figure('Name','GR_1.0_ERR','NumberTitle','off');
hold on;
contourf(0:x_max/n_x:x_max, 0:y_max/n_y:y_max, (ERR_2)');
title('Błąd rozwiązania dla \omega_G = 1.0');
xlabel('x');
ylabel('y');
hold off;
saveas(fig,'../charts/GR_1.0_ERR.bmp');

% wykresy S = S(it) dla LR
fig = figure('Name','LR_S(t)','NumberTitle','off');
hold on;
set(gca, 'XScale', 'log');
plot(0:1:it1_L - 1, S1_vec_L(1:it1_L));
plot(0:1:it2_L - 1, S2_vec_L(1:it2_L));
plot(0:1:it3_L - 1, S3_vec_L(1:it3_L));
plot(0:1:it4_L - 1, S4_vec_L(1:it4_L));
title('Lokalna relaksacja: S(it)');
l1 = sprintf('%s%d', '\omega_G = 1.0, it = ', it1_L);
l2 = sprintf('%s%d', '\omega_G = 1.4, it = ', it2_L);
l3 = sprintf('%s%d', '\omega_G = 1.8, it = ', it3_L);
l4 = sprintf('%s%d', '\omega_G = 1.9, it = ', it4_L);
legend(l1, l2, l3, l4);
xlabel('it');
ylabel('S');
xlim([0 30000]);
hold off;
saveas(fig,'../charts/LR_S(it).bmp');
