% main2c.m - untuk kasus y=0
clear; clc; clear mex; clear functions;
pkg load symbolic

% Define parameters
a = 0; b = 10;  % Integration limits
N_values = [10 50 100 500 1000];  % For composite Simpson
tol = 1e-4;  % For adaptive quadrature
m_values = [4,6,7,9,10];  % For Romberg

% Case y = 0
fprintf('\n=== Results for y=0 ===\n');
f0 = @(x) -log(1 - 1./(1 + exp(-x)));

% Calculate reference value
% Untuk Li₂(x), kita input dilog(1-x)
upper_term1 = (log(1 - 1/(1+exp(-10))))^2 / 2;
upper_term2 = dilog(1 - 1/(1+exp(-10)));
upper_value = upper_term1 + upper_term2;

lower_term1 = (log(1 - 1/(1+exp(0))))^2 / 2;
lower_term2 = dilog(1 - 1/(1+exp(0)));
lower_value = lower_term1 + lower_term2;

ref_value = upper_value - lower_value;
fprintf('Reference value (exact): %.10f\n\n', ref_value);

% Warm-up runs for Simpson
fprintf('\nPerforming warm-up runs for Composite Simpson...\n');
for i = 1:3
   [~, ~] = composite_simpson(f0, a, b, N_values(ceil(length(N_values)/2)));
end

% Test Composite Simpson for y=0
fprintf('\nComposite Simpson Results:\n');
fprintf('N\tResult\t\tTime(s)\t\tRel. Error\n');
results_array = zeros(length(N_values), 1);
error_array = zeros(length(N_values), 1);
times_array = zeros(length(N_values), 1);

for i = 1:length(N_values)
   [result, time] = composite_simpson(f0, a, b, N_values(i));
   rel_error = abs(result - ref_value)/abs(ref_value);
   results_array(i) = result;
   error_array(i) = rel_error;
   times_array(i) = time;
   fprintf('%d\t%.6f\t%.6f\t%.2e\n', N_values(i), result, time, rel_error);
end

% Test Adaptive Quadrature for y=0
fprintf('\nAdaptive Quadrature Result:\n');
[adapt_result0, adapt_subdivs0, adapt_time0] = adaptive_quadrature(f0, a, b, tol);
adapt_error = abs(adapt_result0 - ref_value)/abs(ref_value);
fprintf('Result: %.6f\nSubdivisions: %d\nTime: %.6f s\nRel. Error: %.2e\n', ...
   adapt_result0, adapt_subdivs0, adapt_time0, adapt_error);

% Warm-up runs for Romberg
fprintf('\nPerforming warm-up runs for Romberg Integration...\n');
for i = 1:5
   [~, ~, ~] = romberg_integration(f0, a, b, m_values(ceil(length(m_values)/2)));
end

% Test Romberg for y=0
fprintf('\nRomberg Integration Results:\n');
fprintf('m\tResult\t\tEst. Error\tRel. Error\tTime(s)\n');
romberg_results = zeros(length(m_values), 1);
romberg_est_errors = zeros(length(m_values), 1);  % estimated errors
romberg_rel_errors = zeros(length(m_values), 1);  % relative errors
romberg_times = zeros(length(m_values), 1);

% Simpan hasil ke array saat loop Romberg
for i = 1:length(m_values)
   [result, est_error, R, time] = romberg_integration(f0, a, b, m_values(i));
   rel_error = abs(result - ref_value)/abs(ref_value);
   
   romberg_results(i) = result;
   romberg_est_errors(i) = est_error;
   romberg_rel_errors(i) = rel_error;
   romberg_times(i) = time;
   
   fprintf('%d\t%.6f\t%.2e\t%.2e\t%.6f\n', m_values(i), result, est_error, rel_error, time);
end

% Plot Romberg convergence
figure(4);
clf;
semilogx(2.^(m_values-1), romberg_results, 'bo-', 'LineWidth', 1.5);
hold on;
plot([min(2.^(m_values-1)) max(2.^(m_values-1))], [ref_value ref_value], 'r--', 'LineWidth', 1);
xlabel('Number of subdivisions (N = 2^{m-1})');
ylabel('Integral value');
title('Convergence Analysis - Romberg Integration');
legend('Romberg results', 'Reference value');
grid on;

% Plot Romberg errors
figure(5);
clf;
loglog(2.^(m_values-1), romberg_est_errors, 'bo-', 'LineWidth', 1.5);
hold on;
loglog(2.^(m_values-1), romberg_rel_errors, 'ro-', 'LineWidth', 1.5);
xlabel('Number of subdivisions (N = 2^{m-1})');
ylabel('Error');
title('Error Analysis - Romberg Integration');
legend('Estimated Error', 'Relative Error');
grid on;

% Plot Romberg time
figure(6);
clf;
loglog(2.^(m_values-1), romberg_times, 'go-', 'LineWidth', 1.5);
xlabel('Number of subdivisions (N = 2^{m-1})');
ylabel('Computation Time (s)');
title('Time Analysis - Romberg Integration');
grid on;

% Plot convergence analysis
figure(1);
clf;
loglog(N_values, results_array, 'bo-', 'LineWidth', 1.5);
hold on;
plot([min(N_values) max(N_values)], [ref_value ref_value], 'r--', 'LineWidth', 1);
xlabel('Number of subdivisions (N)');
ylabel('Integral value');
title('Convergence Analysis - Composite Simpson');
legend('Simpson results', 'Reference value');
grid on;

% Plot error analysis
figure(2);
clf;
loglog(N_values, error_array, 'ro-', 'LineWidth', 1.5);
xlabel('Number of subdivisions (N)');
ylabel('Relative Error');
title('Error Analysis - Composite Simpson');
grid on;

% Plot time analysis
figure(3);
clf;
loglog(N_values, times_array, 'go-', 'LineWidth', 1.5);
xlabel('Number of subdivisions (N)');
ylabel('Computation Time (s)');
title('Time Analysis - Composite Simpson');
grid on;