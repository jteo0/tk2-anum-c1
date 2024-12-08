% Data titik
t_points = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540];
x_points = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
y_points = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];

% T range for evaluation
t_eval = linspace(0, 540, 541);

%% Basis Interpolation (Polynomial)
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

%% Plot Comparison
figure;

% Plot for x(t)
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

% Plot for y(t)
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

