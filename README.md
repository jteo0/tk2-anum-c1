# tk2-anum-c2
ayo :D:D

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

compute_basis_analysis(x, y, t);
```

function ```compute_basis_analysis``` akan menghitung condition number dan koefisien untuk setiap pilihan basis dari A hingga D

### Bagian 4

#### Natural Cubic Spline
Run ```script_1_4_2``` yang berisi 
```m
y = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];
x = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];

% Compute spline coefficients for x(t) and y(t)
[a_x, b_x, c_x, d_x] = cubic_spline(t, x);
[a_y, b_y, c_y, d_y] = cubic_spline(t, y);

% Evaluate splines for dense t points
t_dense = linspace(min(t), max(t), 500);
x_dense = arrayfun(@(ti) evaluate_spline(ti, t, a_x, b_x, c_x, d_x), t_dense);
y_dense = arrayfun(@(ti) evaluate_spline(ti, t, a_y, b_y, c_y, d_y), t_dense);

% Plot x vs t
figure;
subplot(2, 1, 1);
plot(t, x, 'o', 'MarkerSize', 8, 'DisplayName', 'Data Points'); hold on;
plot(t_dense, x_dense, 'LineWidth', 1.5, 'DisplayName', 'Cubic Spline');
xlabel('t');
ylabel('x');
title('Cubic Spline Interpolation for x vs t');
grid on;

% Plot y vs t
subplot(2, 1, 2);
plot(t, y, 'o', 'MarkerSize', 8, 'DisplayName', 'Data Points'); hold on;
plot(t_dense, y_dense, 'LineWidth', 1.5, 'DisplayName', 'Cubic Spline');
xlabel('t');
ylabel('y');
title('Cubic Spline Interpolation for y vs t');
grid on;

```
script ini melakukan cubic spline untuk x dan juga y, kemudian membuat visualisasinya

## Nomor 2
Berikut merupakan langkah-langkah yang dijalankan untuk memperoleh hasil eksperimen yang ada pada laporan:

1. Buka dan jalankan file ```main2b.m``` untuk memperoleh hasil integrasi dari ketiga metode dimana y = 1

2. Buka dan jalankan file ```main2c.m``` untuk memperoleh hasil integrasi dari ketiga metode dimana y = 0

### Metode Composite Simpson

### Metode Adaptive Quadrature

### Metode Romberg