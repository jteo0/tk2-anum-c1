function [I, elapsed_time] = composite_simpson(f, a, b, n)
    % Input:
    % f: function handle of the integrand
    % a: lower limit of integration
    % b: upper limit of integration
    % n: number of subintervals (must be even)
    % Output:
    % I: approximate integral value
    % elapsed_time: time taken for computation in seconds

    % Check if n is even
    if mod(n, 2) == 1
        error('n must be an even integer');
    end

    % Start measuring time
    tic;

    % Step size
    h = (b - a) / n;

    % Generate x-values
    x = a:h:b;

    % Compute y-values
    y = f(x); % Evaluate the function at all points

    % Apply Composite Simpson's Rule
    I = (h / 3) * (y(1) + 4 * sum(y(2:2:end-1)) + 2 * sum(y(3:2:end-2)) + y(end));

    % Stop measuring time
    elapsed_time = toc;
end

