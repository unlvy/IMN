clear;

% % % % % % % % % % % %
% 1.1 metoda trapezow %
% % % % % % % % % % % %
% odczyt danych z plikow
file = fopen('../results/T1dt.dat', 'r');
T1dt = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/T1t.dat', 'r');
T1t = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/T1v.dat', 'r');
T1v = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/T1x.dat', 'r');
T1x = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/T2dt.dat', 'r');
T2dt = (fscanf(file, '%f'));
fclose(file);

file = fopen('../results/T2t.dat', 'r');
T2t = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/T2v.dat', 'r');
T2v = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/T2x.dat', 'r');
T2x = (fscanf(file, '%f'))';
fclose(file);

% przedstawienie danych na wykresie
fig = figure('Name','Trapezv','NumberTitle','off');
hold on;
plot(T1t, T1v);
plot(T2t, T2v);
title('Metoda trapezow: v(t)');
xlabel('t');
ylabel('v');
legend('tol = 10^-^2', 'tol = 10^-^5');
hold off;
saveas(fig,'../plots/Trapez_v(t).bmp');

fig = figure('Name','Trapezx','NumberTitle','off');
hold on;
plot(T1t, T1x);
plot(T2t, T2x);
title('Metoda trapezow: x(t)');
xlabel('t');
ylabel('x');
legend('tol = 10^-^2', 'tol = 10^-^5');
hold off;
saveas(fig,'../plots/Trapez_x(t).bmp');

fig = figure('Name','Trapezdt','NumberTitle','off');
hold on;
plot(T1t, T1dt);
plot(T2t, T2dt);
title('Metoda trapezow: dt(t)');
xlabel('t');
ylabel('dt');
legend('tol = 10^-^2', 'tol = 10^-^5');
hold off;
saveas(fig,'../plots/Trapez_dt(t).bmp');

fig = figure('Name','Trapezvx','NumberTitle','off');
hold on;
plot(T1x, T1v);
plot(T2x, T2v);
title('Metoda trapezow: v(x)');
xlabel('v');
ylabel('x');
legend('tol = 10^-^2', 'tol = 10^-^5');
hold off;
saveas(fig,'../plots/Trapez_v(x).bmp');

% % % % % % % % % % 
% 1.2 metoda RK2  %
% % % % % % % % % %
% odczyt danych z plikow
file = fopen('../results/RK21dt.dat', 'r');
RK21dt = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/RK21t.dat', 'r');
RK21t = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/RK21v.dat', 'r');
RK21v = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/RK21x.dat', 'r');
RK21x = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/RK22dt.dat', 'r');
RK22dt = (fscanf(file, '%f'));
fclose(file);

file = fopen('../results/RK22t.dat', 'r');
RK22t = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/RK22v.dat', 'r');
RK22v = (fscanf(file, '%f'))';
fclose(file);

file = fopen('../results/RK22x.dat', 'r');
RK22x = (fscanf(file, '%f'))';
fclose(file);

% przedstawienie danych na wykresie
fig = figure('Name','RK2v','NumberTitle','off');
hold on;
plot(RK21t, RK21v);
plot(RK22t, RK22v);
title('Metoda RK2: v(t)');
xlabel('t');
ylabel('v');
legend('tol = 10^-^2', 'tol = 10^-^5');
hold off;
saveas(fig,'../plots/RK2_x(t).bmp');

fig = figure('Name','RK2x','NumberTitle','off');
hold on;
plot(RK21t, RK21x);
plot(RK22t, RK22x);
title('Metoda RK2: x(t)');
xlabel('t');
ylabel('x');
legend('tol = 10^-^2', 'tol = 10^-^5');
hold off;
saveas(fig,'../plots/RK2_v(t).bmp');

fig = figure('Name','RK2dt','NumberTitle','off');
hold on;
plot(RK21t, RK21dt);
plot(RK22t, RK22dt);
title('Metoda RK2: dt(t)');
xlabel('t');
ylabel('dt');
legend('tol = 10^-^2', 'tol = 10^-^5');
hold off;
saveas(fig,'../plots/RK2_dt(t).bmp');

fig = figure('Name','RK2vx','NumberTitle','off');
hold on;
plot(RK21x, RK21v);
plot(RK22x, RK22v);
title('Metoda trapezow: v(x)');
xlabel('v');
ylabel('x');
legend('tol = 10^-^2', 'tol = 10^-^5');
hold off;
saveas(fig,'../plots/RK2_v(x).bmp');

clear;