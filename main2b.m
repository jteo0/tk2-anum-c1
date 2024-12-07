% main2b.m - untuk kasus y=1
clear; clc; clear mex; clear functions;
pkg load symbolic
% Define parameters
a = 0; b = 10;  % Integration limits
N_values = [10 50 100 500 1000];  % For composite Simpson
tol = 1e-4;  % For adaptive quadrature
m_values = [4 6 7 9 10];  % For Romberg

% Case y = 1
fprintf('\n=== Results for y=1 ===\n');
f1 = @(x) -log(1./(1 + exp(-x)));

% Calculate reference value using polylogarithm formula
% Li₂(-e^(-10)) - Li₂(-1)
% ref_value = dilog(1-(-exp(-10))) - dilog(1-(-1));
ref_value = dilog(1+exp(-10)) - dilog(2);
fprintf('Reference value (exact): %.10f\n\n', ref_value);

% Warm-up runs for Simpson
fprintf('\nPerforming warm-up runs for Composite Simpson...\n');
for i = 1:3
   [~, ~] = composite_simpson(f1, a, b, N_values(ceil(length(N_values)/2)));
end

% Test Composite Simpson for y=1
fprintf('\nComposite Simpson Results:\n');
fprintf('N\tResult\t\tTime(s)\t\tRel. Error\n');
results_array = zeros(length(N_values), 1);
error_array = zeros(length(N_values), 1);
times_array = zeros(length(N_values), 1);

for i = 1:length(N_values)
   [result, time] = composite_simpson(f1, a, b, N_values(i));
   rel_error = abs(result - ref_value)/abs(ref_value);
   results_array(i) = result;
   error_array(i) = rel_error;
   times_array(i) = time;
   fprintf('%d\t%.6f\t%.6f\t%.2e\n', N_values(i), result, time, rel_error);
end

% Array untuk menyimpan rasio
N_ratios = zeros(length(N_values)-1, 1);
time_ratios = zeros(length(N_values)-1, 1);
error_ratios = zeros(length(N_values)-1, 1);

% Hitung rasio
for i = 1:length(N_values)-1
   N_ratios(i) = N_values(i+1)/N_values(i);
   time_ratios(i) = times_array(i+1)/times_array(i);
   error_ratios(i) = error_array(i+1)/error_array(i);
end

% Print comparison table
fprintf('\nComparison Analysis:\n');
fprintf('N1\tN2\tN2/N1\tTime2/Time1\tError2/Error1\n');
for i = 1:length(N_values)-1
   fprintf('%d\t%d\t%.2f\t%.2f\t\t%.2e\n', ...
       N_values(i), N_values(i+1), N_ratios(i), ...
       time_ratios(i), error_ratios(i));
end

% Test Adaptive Quadrature for y=1
fprintf('\nAdaptive Quadrature Result:\n');
[adapt_result1, adapt_subdivs1, adapt_time1] = adaptive_quadrature(f1, a, b, tol);
adapt_error = abs(adapt_result1 - ref_value)/abs(ref_value);
fprintf('Result: %.6f\nSubdivisions: %d\nTime: %.6f s\nRel. Error: %.2e\n', ...
   adapt_result1, adapt_subdivs1, adapt_time1, adapt_error);

% Warm-up runs for Romberg
fprintf('\nPerforming warm-up runs for Romberg Integration...\n');
for i = 1:3
   [~, ~, ~] = romberg_integration(f1, a, b, tol, m_values(ceil(length(m_values)/2)));
end

% Test Romberg for y=1
fprintf('\nRomberg Integration Results:\n');
fprintf('m\tResult\t\tError\t\tTime(s)\n');
for i = 1:length(m_values)
   [result, error, R, time] = romberg_integration(f1, a, b, tol, m_values(i));
   fprintf('%d\t%.6f\t%.6e\t%.6f\n', m_values(i), result, error, time);
end

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