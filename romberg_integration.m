function [result, error, R, time] = romberg_integration(f, a, b, tol, m)
    % Input:
    % f: function handle for the integrand
    % a: lower limit of integration
    % b: upper limit of integration
    % tol: error tolerance
    % m: maximum number of rows in the Romberg table
    % Output:
    % result: the integral approximation
    % error: the estimated error
    % R: the final Romberg table
    % time: execution time

    tic; % Start timing

    R = zeros(m, m); % Initialize Romberg table
    h = b - a;       % Initial step size
    R(1, 1) = (h / 2) * (f(a) + f(b)); % Initial trapezoidal approximation

    for k = 2:m
        % Halve the step size
        h = h / 2;

        % Composite trapezoidal rule for the current step size
        sum = 0;
        for i = 1:2^(k-2)
            sum = sum + f(a + (2 * i - 1) * h);
        end
        R(k, 1) = R(k-1, 1) / 2 + h * sum;

        % Richardson extrapolation
        for j = 2:k
            R(k, j) = R(k, j-1) + (R(k, j-1) - R(k-1, j-1)) / (4^(j-1) - 1);
        end

        % Check for convergence
        if abs(R(k, k) - R(k-1, k-1)) < tol
            result = R(k, k);
            error = abs(R(k, k) - R(k-1, k-1));
            R = R(1:k, 1:k); % Trim the Romberg table to the used size
            time = toc; % End timing
            return;
        end
    end

    % If convergence is not reached within m iterations
    result = R(m, m);
    error = abs(R(m, m) - R(m-1, m-1));
    time = toc; % End timing
    warning('Romberg integration did not converge within the specified refinement levels');
end

