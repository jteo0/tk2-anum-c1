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