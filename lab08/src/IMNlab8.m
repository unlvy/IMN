%clc; clear;

% przyjete stale
c.n_x = 400;
c.n_y = 90;
c.i_1 = 200;
c.i_2 = 210;
c.j_1 = 50;
c.delta = 0.01;
c.sigma = 10 * c.delta;
c.x_A = 0.45;
c.y_A = 0.45;
c.it = 10000;

% 1. Pole predkosci
[V_x, V_y, dt] = velocityField('../psi.dat', c, false);

% 2. D = 0;
[t_vec, ct_vec, xsr_vec] = CrankNicolson(c, V_x, V_y, dt, 0);



% 3. D = 0.1;
[t_vec2, ct_vec2, xsr_vec2] = CrankNicolson(c, V_x, V_y, dt, 0.1);

fig = figure; hold on;
subplot(2, 1, 1);
plot(t_vec, xsr_vec, t_vec, ct_vec);
legend('{\itx_s_r}', '{\itc_s_r}');
title('{\itD} = 0');
ylabel('{\itx_s_r}({\itc_s_r})');
xlabel('{\itt}');
subplot(2, 1, 2);
plot(t_vec2, xsr_vec2, t_vec2, ct_vec2);
legend('{\itx_s_r}', '{\itc_s_r}');
title('{\itD} = 0.1');
ylabel('{\itx_s_r}({\itc_s_r})');
xlabel('{\itt}');
hold off;
saveas(fig, '../charts/xsr_csr.bmp');
