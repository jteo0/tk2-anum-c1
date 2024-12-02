% main2b.m - untuk kasus y=1
clear; clc; clear mex; clear functions;

% Define parameters
a = 0; b = 10;  % Integration limits
N_values = [10 50 100 500 1000];  % For composite Simpson
tol = 1e-4;  % For adaptive quadrature
m_values = [4 6 7 9 10];  % For Romberg

% Case y = 1
fprintf('\n=== Results for y=1 ===\n');
f1 = @(x) -log(1./(1 + exp(-x)));

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

% Test Adaptive Quadrature for y=1
fprintf('\nAdaptive Quadrature Result:\n');
[adapt_result1, adapt_subdivs1, adapt_time1] = adaptive_quadrature(f1, a, b, tol);
fprintf('Result: %.6f\nSubdivisions: %d\nTime: %.6f s\n', ...
    adapt_result1, adapt_subdivs1, adapt_time1);

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