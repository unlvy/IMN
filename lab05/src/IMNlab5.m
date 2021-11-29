clc; clear;

% przyjęte wartości parametrów
delta = 0.2;
n_x = 128;
n_y = 128;
x_max = delta * n_x;
y_max = delta * n_y;
TOL = 1e-8;
k = 16;

% warunki brzegowe
borders = {
    @(y) (sin(pi * y / y_max)), ...         % x = 0
    @(x) (-sin(2 * pi * x / x_max)), ...    % y = n_y
    @(y) (sin(pi * y / y_max)), ...         % x = n_x
    @(x) (sin(2 * pi * x / x_max))          % y = 0
};

multigridRelaxation(borders, x_max, y_max, n_x, n_y, delta, k, TOL);