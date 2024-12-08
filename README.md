# tk2-anum-c2s
## Nomor 1

### Bagian 1

Berikut merupakan langkah-langkah untuk mendapat hasil yang dipaparkan pada laporan (semua function ada pada file zip):

1. Run file ```bagian1.py``` untuk memunculkan sebuah window dengan ilustrasi gambar yang diberikan. Saat mouse hover di atas window tersebut akan memunculkan koordinat pixel dari ilustrasi tersebut, dan saat diklik akan print koordinat tersebut.

2. Run file ```bagian1_visual.py``` untuk membuat visualisasi dari koordinat pixel yang telah dicatat

### Bagian 2

Run ```script_1_2``` yang berisi
```m
y = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];
x = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
t = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540];

[A_A, A_B, A_C, A_D, c_x, c_y] = compute_basis_analysis(x, y, t);
```

function ```compute_basis_analysis``` akan menghitung condition number dan koefisien untuk setiap pilihan basis dari A hingga D

### Bagian 3
Run ```script_3``` untuk menghasilkan plot kedua polinomial dengan basis D pada interval dari *frame* ke−0 hingga *frame* ke−540.

```script_3``` pertama-tama program akan mencari persamaan koefisien c10<sub>x</sub> dan c10<sub>y</sub> untuk membentuk polinomial p<sub>10</sub>(t).

Setelah itu, barulah program mengevaluasi p<sub>9</sub>(t) dan p<sub>10</sub>(t) pada interval dari *frame* ke−0 hingga *frame* ke−540.

### Bagian 4

#### Interpolasi Newton
Jika ingin mencari koefisien dari polinomial dengan basis Newton, jalankan program berikut
```m
t = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540];
x = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
y = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];
cx = divided_differences(t, x)
cy = divided_differences(t, y)
```

Run ```analyze_newton_interpolation``` untuk menghasilkan plot kedua polinomial dengan basis Newton pada interval dari *frame* ke−0 hingga *frame* ke−540.

#### Natural Cubic Spline
Run ```script_1_4_2``` yang berisi 
```m
y = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45]; 
x = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
t = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540];

% Natural Cubic Spline Coefficients
[a_x, b_x, c_x, d_x] = cubic_spline(t, x); % Spline for x(t)
[a_y, b_y, c_y, d_y] = cubic_spline(t, y); % Spline for y(t)

% Generate Dense Time Points for Smooth Interpolation
t_dense = linspace(min(t), max(t), 80);

% Evaluate Natural Cubic Spline at Dense Points
x_spline = arrayfun(@(ti) evaluate_spline(ti, t, a_x, b_x, c_x, d_x), t_dense);
y_spline = arrayfun(@(ti) evaluate_spline(ti, t, a_y, b_y, c_y, d_y), t_dense);

% Plot x(t)
figure;
subplot(2, 1, 1); % First subplot for x(t)
plot(t, x, 'ro', 'MarkerSize', 8, 'DisplayName', 'Data Points'); hold on;
plot(t_dense, x_spline, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Cubic Spline');
xlabel('t');
ylabel('x');
title('Comparison: Natural Cubic Spline vs Basis Interpolation (x(t))');
grid on;

% Plot y(t)
subplot(2, 1, 2); % Second subplot for y(t)
plot(t, y, 'ro', 'MarkerSize', 8, 'DisplayName', 'Data Points'); hold on;
plot(t_dense, y_spline, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Cubic Spline');
xlabel('t');
ylabel('y');
title('Comparison: Natural Cubic Spline vs Basis Interpolation (y(t))');
grid on;
```
script ini melakukan cubic spline untuk x dan juga y, kemudian membuat visualisasinya

Selain itu, run ```script_1_4_compare``` yang berisi
```m
t_points = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540];
x_points = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
y_points = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];

t_eval = linspace(0, 540, 541);

%% Basis Interpolation
% Coefficients from basis interpolation
c_x_basis = [2.5926e+00, 1.6123e-01, 1.2574e-01, -2.8417e-03, -2.7016e-02, -9.4590e-03, -1.4685e-03, -1.1790e-04, -4.7686e-06, -7.6807e-08];
c_y_basis = [4.0000e+01, 2.5000e+00, -3.8652e-15, 2.0355e-15, 1.1827e-15, 2.4839e-16, 2.7623e-17, 1.7306e-18, 5.7824e-20, 8.0311e-22];
p_basis_x = arrayfun(@(t) evaluate_basis_D(t, c_x_basis), t_eval);
p_basis_y = arrayfun(@(t) evaluate_basis_D(t, c_y_basis), t_eval);

%% Natural Cubic Spline Interpolation
[a_x, b_x, c_x_spline, d_x] = cubic_spline(t_points, x_points);
[a_y, b_y, c_y_spline, d_y] = cubic_spline(t_points, y_points);
x_spline = arrayfun(@(t) evaluate_spline(t, t_points, a_x, b_x, c_x_spline, d_x), t_eval);
y_spline = arrayfun(@(t) evaluate_spline(t, t_points, a_y, b_y, c_y_spline, d_y), t_eval);

%% Newton Interpolation
c_x_newton = divided_differences(t_points, x_points);
c_y_newton = divided_differences(t_points, y_points);
p_newton_x = arrayfun(@(t) evaluate_newton(t, t_points, c_x_newton), t_eval);
p_newton_y = arrayfun(@(t) evaluate_newton(t, t_points, c_y_newton), t_eval);

figure;

% Plot x(t)
subplot(2, 1, 1);
plot(t_eval, x_spline, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Cubic Spline');
hold on;
plot(t_eval, p_basis_x, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Basis Interpolation');
plot(t_eval, p_newton_x, 'g-.', 'LineWidth', 1.5, 'DisplayName', 'Newton Interpolation');
plot(t_points, x_points, 'ko', 'DisplayName', 'Data Points');
xlabel('t');
ylabel('x');
title('Comparison of Interpolation Methods for x(t)');
legend('Basis Interpolation', 'Newton Interpolation', 'Cubic Spline', 'Location','southeast');
grid on;

% Plot y(t)
subplot(2, 1, 2);
plot(t_eval, y_spline, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Cubic Spline');
hold on;
plot(t_eval, p_basis_y, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Basis Interpolation');
plot(t_eval, p_newton_y, 'g-.', 'LineWidth', 1.5, 'DisplayName', 'Newton Interpolation');
plot(t_points, y_points, 'ko', 'DisplayName', 'Data Points');
xlabel('t');
ylabel('y');
title('Comparison of Interpolation Methods for y(t)');
legend('Basis Interpolation', 'Newton Interpolation', 'Cubic Spline', 'Location','southeast');
grid on;
```
script ini akan menghasilkan plot ketiga bentuk interpolasi yang berbeda pada satu graf, baik untuk x maupun y.

## Nomor 2
Berikut merupakan langkah-langkah yang dijalankan untuk memperoleh hasil eksperimen yang ada pada laporan:

1. Buka dan jalankan file ```main2b.m``` untuk memperoleh hasil integrasi dari ketiga metode dimana y = 1

2. Buka dan jalankan file ```main2c.m``` untuk memperoleh hasil integrasi dari ketiga metode dimana y = 0

### Metode Composite Simpson
Pada kode ```main2b.m```, snippet berikut akan memanggil ```composite_simpson.m``` yang mencari hasil integral menurut fungsi, interval, dan jumlah subdivisi yang telah ditentukan menggunakan metode <i>composite</i> simpson. Selain hasil integral, waktu komputasi juga disimpan dan dikeluarkan.
```
% Warm-up runs for Simpson
fprintf('\nPerforming warm-up runs for Composite Simpson...\n');
for i = 1:3  % Do 3 warm-up runs with middle N value
    [~, ~] = composite_simpson(f1, a, b, N_values(ceil(length(N_values)/2)));
end

% Test Composite Simpson for y=1
fprintf('\nComposite Simpson Results:\n');
fprintf('N\tResult\t\tTime(s)\n');
for i = 1:length(N_values)
    [result, time] = composite_simpson(f1, a, b, N_values(i));
    fprintf('%d\t%.6f\t%.6f\n', N_values(i), result, time);
end
```

Untuk ```main2c.m```, snippet yang dijalankan untuk <i>composite</i> simpson adalah:
```
% Warm-up runs for Simpson
fprintf('\nPerforming warm-up runs for Composite Simpson...\n');
for i = 1:3  % Do 3 warm-up runs with middle N value
    [~, ~] = composite_simpson(f0, a, b, N_values(ceil(length(N_values)/2)));
end

% Test Composite Simpson for y=0
fprintf('\nComposite Simpson Results:\n');
fprintf('N\tResult\t\tTime(s)\n');
for i = 1:length(N_values)
    [result, time] = composite_simpson(f0, a, b, N_values(i));
    fprintf('%d\t%.6f\t%.6f\n', N_values(i), result, time);
end
```

### Metode Adaptive Quadrature
Snippet berikut pada ```main2b.m``` akan memanggil ```adaptive_quadrature.m``` untuk menerapkan metode integrasi <i>adaptive</i> quadrature untuk menghitung integral numerik, jumlah subdivisi yang digunakan, dan waktu komputasinya.
```
% Test Adaptive Quadrature for y=1
fprintf('\nAdaptive Quadrature Result:\n');
[adapt_result1, adapt_subdivs1, adapt_time1] = adaptive_quadrature(f1, a, b, tol);
fprintf('Result: %.6f\nSubdivisions: %d\nTime: %.6f s\n', ...
    adapt_result1, adapt_subdivs1, adapt_time1);
```

Berikut adalah snippet di ```main2c.m```:
```
% Test Adaptive Quadrature for y=0
fprintf('\nAdaptive Quadrature Result:\n');
[adapt_result0, adapt_subdivs0, adapt_time0] = adaptive_quadrature(f0, a, b, tol);
fprintf('Result: %.6f\nSubdivisions: %d\nTime: %.6f s\n', ...
    adapt_result0, adapt_subdivs0, adapt_time0);
```

### Metode Romberg
Berikut adalah snippet ```main2b.m``` yang menggunakan integrasi romberg dengan memanggil ```romberg_integration.m``` untuk menghitung integral numerik, serta menunjukkan waktu komputasi dan error:
```
% Warm-up runs for Romberg
fprintf('\nPerforming warm-up runs for Romberg Integration...\n');
for i = 1:3  % Do 3 warm-up runs with middle m value
    [~, ~, ~] = romberg_integration(f1, a, b, tol, m_values(ceil(length(m_values)/2)));
end

% Test Romberg for y=1
fprintf('\nRomberg Integration Results:\n');
fprintf('m\tResult\t\tError\t\tTime(s)\n');
for i = 1:length(m_values)
    [result, error, R, time] = romberg_integration(f1, a, b, tol, m_values(i));
    fprintf('%d\t%.6f\t%.6e\t%.6f\n', m_values(i), result, error, time);
end
```

Berikut adalah snippet dari ```main2.m```:
```
% Warm-up runs for Romberg
fprintf('\nPerforming warm-up runs for Romberg Integration...\n');
for i = 1:3  % Do 3 warm-up runs with middle m value
    [~, ~, ~] = romberg_integration(f0, a, b, tol, m_values(ceil(length(m_values)/2)));
end

% Test Romberg for y=0
fprintf('\nRomberg Integration Results:\n');
fprintf('m\tResult\t\tError\t\tTime(s)\n');
for i = 1:length(m_values)
    [result, error, R, time] = romberg_integration(f0, a, b, tol, m_values(i));
    fprintf('%d\t%.6f\t%.6e\t%.6f\n', m_values(i), result, error, time);
end
```