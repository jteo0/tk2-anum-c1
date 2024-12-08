y = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45]; % y-coordinates
x = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55]; % x-coordinates (speed)
t = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540]; % t-coordinates

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