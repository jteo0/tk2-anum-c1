% Data titik dan koefisien sebelumnya
t_points = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540];
x_points = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
y_points = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];

% Koefisien sebelumnya (hasil dari perhitungan sebelumnya)
c_x = [2.5926e+00, 1.6123e-01, 1.2574e-01, -2.8417e-03, -2.7016e-02, -9.4590e-03, -1.4685e-03, -1.1790e-04, -4.7686e-06, -7.6807e-08];
c_y = [4.0000e+01, 2.5000e+00, -3.8652e-15, 2.0355e-15, 1.1827e-15, 2.4839e-16, 2.7623e-17, 1.7306e-18, 5.7824e-20, 8.0311e-22];

% Koordinat baru pada t = 600
t_new = 600;
x_new = 2.336957;
y_new = 50;

% Langkah 3: Hitung s untuk t = 600
s = (t_new - 480) / 30; % s = 4

% Langkah 4: Evaluasi p9(t_new) menggunakan metode Horner
p9_x = evaluate_basis_D(t_new, c_x);
p9_y = evaluate_basis_D(t_new, c_y);

% Langkah 5: Hitung c10
s_power_10 = s^10;

c10_x = (x_new - p9_x) / s_power_10;
c10_y = (y_new - p9_y) / s_power_10;

% Langkah 6: Perbarui koefisien
c_x_new = [c_x, c10_x];
c_y_new = [c_y, c10_y];

% Langkah 7: Evaluasi p9(t) dan p10(t) pada interval t = 0 hingga t = 540
t_eval = linspace(0, 540, 541);

% Fungsi evaluasi
p9_x_eval = arrayfun(@(t) evaluate_basis_D(t, c_x), t_eval);
p9_y_eval = arrayfun(@(t) evaluate_basis_D(t, c_y), t_eval);

p10_x_eval = arrayfun(@(t) evaluate_basis_D(t, c_x_new), t_eval);
p10_y_eval = arrayfun(@(t) evaluate_basis_D(t, c_y_new), t_eval);

% Langkah 8: Plot kedua polinomial
figure;
subplot(2,1,1);
plot(t_eval, p9_x_eval, 'b-', 'LineWidth', 1.5);
hold on;
plot(t_eval, p10_x_eval, 'r--', 'LineWidth', 1.5);
title('Polinomial Interpolasi untuk x');
xlabel('t');
ylabel('x');
legend('p_9(t)', 'p_{10}(t)');
grid on;

subplot(2,1,2);
plot(t_eval, p9_y_eval, 'b-', 'LineWidth', 1.5);
hold on;
plot(t_eval, p10_y_eval, 'r--', 'LineWidth', 1.5);
title('Polinomial Interpolasi untuk y');
xlabel('t');
ylabel('y');
legend('p_9(t)', 'p_{10}(t)');
grid on;
