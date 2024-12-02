% Main script untuk eksperimen Binary Cross-Entropy Integration
clear; clc;

% Define parameters
a = 0; b = 10;  % Integration limits
N_values = [10 50 100 500 1000];  % For composite Simpson
tol = 1e-4;  % For adaptive quadrature
m_values = [4 6 7 9 10];  % For Romberg

% Run experiments for both y=1 and y=0
for y_case = [1 0]
    % Define integrand function based on y
    if y_case == 1
        fprintf('\n=== Results for y=1 ===\n');
        f = @(x) -log(1./(1 + exp(-x)));
    else
        fprintf('\n=== Results for y=0 ===\n');
        f = @(x) -log(1 - 1./(1 + exp(-x)));
    end
    
    % Test Composite Simpson
    fprintf('\nComposite Simpson Results:\n');
    fprintf('N\tResult\t\tTime(s)\n');
    for i = 1:length(N_values)
        [result, time] = composite_simpson(f, a, b, N_values(i));
        fprintf('%d\t%.6f\t%.6f\n', N_values(i), result, time);
    end

    % Test Adaptive Quadrature
    fprintf('\nAdaptive Quadrature Result:\n');
    [adapt_result, adapt_subdivs, adapt_time] = adaptive_quadrature(f, a, b, tol);
    fprintf('Result: %.6f\nSubdivisions: %d\nTime: %.6f s\n', ...
        adapt_result, adapt_subdivs, adapt_time);

    % Test Romberg Integration
    fprintf('\nRomberg Integration Results:\n');
    fprintf('m\tResult\t\tError\t\tTime(s)\n');
    for i = 1:length(m_values)
        tic;
        [result, error, R] = romberg_integration(f, a, b, tol, m_values(i));
        time = toc;
        fprintf('%d\t%.6f\t%.6e\t%.6f\n', m_values(i), result, error, time);
    end
end