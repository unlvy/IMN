clear;

% % % % % % % % % % % % % % % % % % % % % %
% 1.1 metoda trapezow + iteracja Picarda  %
% % % % % % % % % % % % % % % % % % % % % %
% odczyt danych z plikow
file = fopen('../results/T_P.dat', 'r');
T_P = (fscanf(file, '%f'))';
fclose(file);

% generowanie wektora t
t = 0 : 0.1 : 100;

% przedstawienie danych na wykresie
figure('Name','T+P','NumberTitle','off');
hold on;
scatter(t, T_P, 20, 'green', 'filled');
scatter(t, 500 - T_P, 20, 'blue', 'filled');
title('Metoda trapezow z iteracja Picarda');
xlabel('t');
ylabel('u(t)');
legend('u_n', 'N - u_n');
hold off;

% % % % % % % % % % % % % % % % % % % % % %
% 1.2 metoda trapezow + iteracja Newtona  %
% % % % % % % % % % % % % % % % % % % % % %
% odczyt danych z plikow
file = fopen('../results/T_N.dat', 'r');
T_N = (fscanf(file, '%f'))';
fclose(file);

% przedstawienie danych na wykresie
figure('Name','T+N','NumberTitle','off');
hold on;
scatter(t, T_N, 20, 'green', 'filled');
scatter(t, 500 - T_N, 20, 'blue', 'filled');
title('Metoda trapezow z iteracja Newtona');
xlabel('t');
ylabel('u(t)');
legend('u_n', 'N - u_n');
hold off;

% % % % % % % % % % % % %
% 2 metoda niejawna RK2 %
% % % % % % % % % % % % %
% odczyt danych z plikow
file = fopen('../results/RK2.dat', 'r');
RK2 = (fscanf(file, '%f'))';
fclose(file);

% przedstawienie danych na wykresie
figure('Name','RK2','NumberTitle','off');
hold on;
scatter(t, RK2, 20, 'green', 'filled');
scatter(t, 500 - RK2, 20, 'blue', 'filled');
title('Metoda niejawna RK2');
xlabel('t');
ylabel('u(t)');
legend('u_n', 'N - u_n');
hold off;

clear;
