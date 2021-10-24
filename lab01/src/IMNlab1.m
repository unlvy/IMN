clear;

% % % % % % % % % % % % % %
% 1.1 metoda jawna Eulera %
% % % % % % % % % % % % % %
% odczyt danych z plikow
file = fopen('../results/t1.dat','r');
t1 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/t2.dat','r');
t2 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/t3.dat','r');
t3 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/FEMy1.dat','r');
FEMy1 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/FEMy2.dat','r');
FEMy2 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/FEMy3.dat','r');
FEMy3 = fscanf(file, '%f');
fclose(file);

% funckja wykladnicza
syms t;
f = exp(-1 * t);

% pierwszy wykres: porownanie wyniku numerycznego z analitycznym
figure('Name','FEM','NumberTitle','off');
hold on;
fplot(f, 'Linewidth', 5);
scatter(t1, FEMy1, 10, 'green', 'filled');
scatter(t2, FEMy2, 20, 'blue', 'filled');
scatter(t3, FEMy3, 20, 'red', 'filled');
title('Metoda jawna Eulera: e^-^t');
xlim([0 5]);
xlabel('t');
ylabel('y');
legend('e^-^t', '\deltat = 0.01', '\deltat = 0.1', '\deltat = 1');
hold off;

f = exp(-1 * t1);
FEMy1 = FEMy1 - f;
f = exp(-1 * t2);
FEMy2 = FEMy2 - f;
f = exp(-1 * t3);
FEMy3 = FEMy3 - f;

% drugi wykres: bledy
figure('Name','FEM errors','NumberTitle','off');
hold on;
scatter(t1, FEMy1, 20, 'green', 'filled');
scatter(t2, FEMy2, 20, 'blue', 'filled');
scatter(t3, FEMy3, 20, 'red', 'filled');
title('Metoda jawna Eulera: zmiany błędu globalnego \delta(t)');
xlim([0 5]);
ylim([-0.5 0.1]);
xlabel('t');
ylabel('y');
legend('\deltat = 0.01', '\deltat = 0.1', '\deltat = 1', 'Location', 'southeast');
hold off;

% % % % % % % % % % % % % % % % % %
% 1.2 Metoda jawna RK2 (trapezow) %
% % % % % % % % % % % % % % % % % %
% odczyt danych z plikow
file = fopen('../results/RK2y1.dat','r');
RK2y1 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RK2y2.dat','r');
RK2y2 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RK2y3.dat','r');
RK2y3 = fscanf(file, '%f');
fclose(file);

% funckja wykladnicza
syms t;
f = exp(-1 * t);

% pierwszy wykres: porownanie wyniku numerycznego z analitycznym
figure('Name','RK2','NumberTitle','off');
hold on;
fplot(f, 'Linewidth', 5);
scatter(t1, RK2y1, 10, 'green', 'filled');
scatter(t2, RK2y2, 20, 'blue', 'filled');
scatter(t3, RK2y3, 20, 'red', 'filled');
title('Metoda jawna RK2: e^-^t');
xlim([0 5]);
xlabel('t');
ylabel('y');
legend('e^-^t', '\deltat = 0.01', '\deltat = 0.1', '\deltat = 1');
hold off;

f = exp(-1 * t1);
RK2y1 = RK2y1 - f;
f = exp(-1 * t2);
RK2y2 = RK2y2 - f;
f = exp(-1 * t3);
RK2y3 = RK2y3 - f;

% drugi wykres: bledy
figure('Name','RK2 errors','NumberTitle','off');
hold on;
scatter(t1, RK2y1, 20, 'green', 'filled');
scatter(t2, RK2y2, 20, 'blue', 'filled');
scatter(t3, RK2y3, 20, 'red', 'filled');
title('Metoda jawna RK2: zmiany błędu globalnego \delta(t)');
xlim([0 5]);
ylim([-0.1 0.2]);
xlabel('t');
ylabel('y');
legend('\deltat = 0.01', '\deltat = 0.1', '\deltat = 1', 'Location', 'southeast');
hold off;

% % % % % % % % % % % % % % % % % %
% 1.3 Metoda jawna RK2 (trapezow) %
% % % % % % % % % % % % % % % % % %
% odczyt danych z plikow
file = fopen('../results/RK4y1.dat','r');
RK4y1 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RK4y2.dat','r');
RK4y2 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RK4y3.dat','r');
RK4y3 = fscanf(file, '%f');
fclose(file);

% funckja wykladnicza
syms t;
f = exp(-1 * t);

% pierwszy wykres: porownanie wyniku numerycznego z analitycznym
figure('Name','RK4','NumberTitle','off');
hold on;
fplot(f, 'Linewidth', 5);
scatter(t1, RK4y1, 10, 'green', 'filled');
scatter(t2, RK4y2, 20, 'blue', 'filled');
scatter(t3, RK4y3, 20, 'red', 'filled');
title('Metoda jawna RK4: e^-^t');
xlim([0 5]);
xlabel('t');
ylabel('y');
legend('e^-^t', '\deltat = 0.01', '\deltat = 0.1', '\deltat = 1');
hold off;

f = exp(-1 * t1);
RK4y1 = RK4y1 - f;
f = exp(-1 * t2);
RK4y2 = RK4y2 - f;
f = exp(-1 * t3);
RK4y3 = RK4y3 - f;

% drugi wykres: bledy
figure('Name','RK4 errors','NumberTitle','off');
hold on;
scatter(t1, RK4y1, 20, 'green', 'filled');
scatter(t2, RK4y2, 20, 'blue', 'filled');
scatter(t3, RK4y3, 20, 'red', 'filled');
title('Metoda jawna RK4: zmiany błędu globalnego \delta(t)');
xlim([0 5]);
ylim([-0.01 0.01]);
xlabel('t');
ylabel('y');
legend('\deltat = 0.01', '\deltat = 0.1', '\deltat = 1', 'Location', 'southeast');
hold off;

% % % % % % 
% 2. RRZ2 %
% % % % % %

% odczyt z pliku
file = fopen('../results/RRZ2t1.dat','r');
t1 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2t2.dat','r');
t2 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2t3.dat','r');
t3 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2t4.dat','r');
t4 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2q1.dat','r');
q1 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2q2.dat','r');
q2 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2q3.dat','r');
q3 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2q4.dat','r');
q4 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2i1.dat','r');
i1 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2i2.dat','r');
i2 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2i3.dat','r');
i3 = fscanf(file, '%f');
fclose(file);

file = fopen('../results/RRZ2i4.dat','r');
i4 = fscanf(file, '%f');
fclose(file);

% prezentacja wynikow na wykresie
figure('Name','RRZ2','NumberTitle','off');
hold on;
subplot(2, 4, 1);
scatter(t1, q1, 20, 'green', 'filled');
title('Q(t), \omega\nu = 0.5\omega_0');
xlabel('t');
ylabel('Q(t)');
subplot(2, 4, 5);
scatter(t1, i1, 20, 'blue', 'filled');
title('I(t), \omega\nu = 0.5\omega_0');
xlabel('t');
ylabel('I(t)');
subplot(2, 4, 2);
scatter(t2, q2, 20, 'green', 'filled');
title('Q(t), \omega\nu = 0.8\omega_0');
xlabel('t');
ylabel('Q(t)');
subplot(2, 4, 6);
scatter(t2, i2, 20, 'blue', 'filled');
title('I(t), \omega\nu = 0.8\omega_0');
xlabel('t');
ylabel('I(t)');
subplot(2, 4, 3);
scatter(t3, q3, 20, 'green', 'filled');
title('Q(t), \omega\nu = 1.0\omega_0');
xlabel('t');
ylabel('Q(t)');
subplot(2, 4, 7);
scatter(t3, i3, 20, 'blue', 'filled');
title('I(t), \omega\nu = 1.0\omega_0');
xlabel('t');
ylabel('I(t)');
subplot(2, 4, 4);
scatter(t4, q4, 20, 'green', 'filled');
title('Q(t), \omega\nu = 1.2\omega_0');
xlabel('t');
ylabel('Q(t)');
subplot(2, 4, 8);
scatter(t4, i4, 20, 'blue', 'filled');
title('I(t), \omega\nu = 1.2\omega_0');
xlabel('t');
ylabel('I(t)');
hold off;

clear;
